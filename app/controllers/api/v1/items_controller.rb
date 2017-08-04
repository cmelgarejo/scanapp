class Api::V1::ItemsController < ApiController
  before_action :set_resource,  only: [:show]
  before_action :set_item_list, only: [:index, :search]

  def index
    box = /\(((?:-?\d*\.)?\d+),((?:-?\d*\.)?\d+)\),\(((?:-?\d*\.)?\d+),((?:-?\d*\.)?\d+)\)/.match(params[:box]) ? params[:box] : nil #if there's a bounding box, filter the items by that.
    point = /((?:-?\d*\.)?\d+),((?:-?\d*\.)?\d+)/.match(params[:point]) ? params[:point] : nil
    country = params[:country]
    state = params[:state]
    city= params[:city]
    @item_list.where!(country: country) if country && state.nil? && city.nil?
    @item_list.where!(country: country, city: city) if country && state.nil? && city
    @item_list.where!(country: country, state: state) if country && state && city.nil?
    @item_list.where!(country: country, state: state, city: city) if country && state && city
    @item_list.where!([':box::box @> point(lat, lng)', {box: box}]) if box
    @item_list.where!(['(:point::point <-> point(lat, lng)) * 100000) < 100', {point: point}]) if point
    json_response @item_list, except: item_list_except_fields
  end

  def show
    json_response @resource, include: {
        attachment: {except: attachment_except_fields},
        company: {except: company_except_fields},
        #template: {except: template_except_fields},
        parents: {except: parents_except_fields},
        children: {except: parents_except_fields},
        categories: {except: categories_except_fields}
    }, except: item_except_fields
  end

  def search
    @item_list.where!('label ILIKE ?', "%#{params[:search_term]}%")
    json_response @item_list, except: item_list_except_fields
  end

  private

  def template_except_fields
    (generic_except_fields << %w(label description color_reference lat lng enabled is_template is_root company_id item_id)).flatten
  end

  def parents_except_fields
    (generic_except_fields << %w(is_template is_root company_id item_id country state city extra_properties)).flatten
  end

  def categories_except_fields
    (template_except_fields << %w(extra_properties)).flatten
  end

  def attachment_except_fields
    (generic_except_fields << %w(id)).flatten
  end

  def company_except_fields
    (generic_except_fields << %w(enabled)).flatten
  end

  def generic_except_fields
    %w(qrcode company_id item_id created_at updated_at)
  end

  def item_except_fields
    %w(qrcode company_id item_id country state city)
  end

  def item_list_except_fields
    (item_except_fields << generic_except_fields << %w(country state city enabled is_template is_root extra_properties lat lng)).flatten
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    if @current_user.admin?
      @resource = Item.includes(:item_categories).where(id: params[:id], enabled: true)
    else
      @resource = Item.includes(:item_categories)
                      .where(id: params[:id], enabled: true,
                             item_categories: {category_id: current_user.categories.map(&:id)}) #has my current categories
    end
  end

  def set_item_list
    if @current_user.admin?
      @item_list = Item.includes(:item_categories)
    else
      @item_list= Item.includes(:item_categories)
                 .where(enabled: true,
                        item_categories: {category_id: current_user.categories.map(&:id)}) #has my current categories
    end
  end
end

