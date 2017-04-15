class Api::V1::ItemsController < ApiController
  before_action :set_resource, only: [:show]

  def index
    json_response Item.where(enabled: true), except: item_list_except_fields
  end

  def show
    json_response @resource, include: {
          attachment: {except: attachment_except_fields},
          company: {except: company_except_fields},
          template: {except: template_except_fields},
          parents: {except: parents_except_fields}
        }, except: item_except_fields
  end

  private

  def template_except_fields
    (generic_except_fields << %w(label description color_reference lat lng enabled is_template is_root company_id item_id)).flatten
  end

  def parents_except_fields
    (template_except_fields << :extra_properties).flatten
  end

  def attachment_except_fields
    (generic_except_fields << %w(id)).flatten
  end

  def company_except_fields
    (generic_except_fields << :enabled).flatten
  end

  def generic_except_fields
    %w(qrcode company_id item_id created_at updated_at)
  end

  def item_except_fields
    %w(qrcode company_id item_id)
  end

  def item_list_except_fields
    (item_except_fields << generic_except_fields << %w(enabled is_template is_root extra_properties lat lng)).flatten
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Item.where(enabled: true, id: params[:id])
  end
end

