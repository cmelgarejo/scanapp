ActiveAdmin.register Item do
  permit_params :label, :description, :color_reference, :picture, :lat, :lng, :enabled, :is_template, :is_root,
                :extra_properties, :company_id, :path,
                attachments_attributes: [ :id, :item_id ]
  # :qrcode,
  # :company,
  # :item

  before_create do |item|
    item.company = current_user.company
  end

  index do
    selectable_column
    #id_column
    column I18n.t('Label'), sortable: :label do |item|
      link_to item.label, admin_item_path(item)
    end
    column I18n.t('QRCode') do |item|
      raw "<div style='border-left: 25px solid #{item.color_reference};margin-top:50px;margin-bottom:50px'>
            #{link_to image_tag(RQRCode::QRCode.new(item.id, :size => 8, :level => :h).as_png.to_data_url),
                      admin_item_path(item)}</div>"

    end
    column I18n.t('Description'), :description
    list_column :my_categories
    column I18n.t('Color_Reference'), sortable: :color_reference do |item|
      raw "<div style='background-color: #{item.color_reference}; border: 2px solid black; width: 20px; height: 20px' title='#{item.color_reference}'></div>"
    end
    bool_column I18n.t('Enabled'), :enabled, sortable: :enabled
    #bool_column I18n.t('IsRootItem'), :is_root
    column I18n.t('Created_at'), :created_at
    column I18n.t('Updated_at'), :updated_at
    actions defaults: true do |item|
      link_to I18n.t('Print'), "#{admin_item_path(item)}/pdf", target: '_blank'
    end
  end

  filter :label
  filter :description
  filter :color_reference, as: :select, input_html: {class: "color-reference-select"} #collection: proc { Item.all.map(&:color_reference).uniq }
  filter :categories, as: :select
  filter :enabled
  filter :is_root, label: I18n.t('IsRootItem')
  filter :created_at
  filter :updated_at

  show do
    # within @head do
    #   script src: 'https://api-maps.yandex.ru/2.1/?lang=es&load=Map,Placemark', type: 'text/javascript'
    # end
    tabs do
      tab I18n.t('Item_Details') do
        attributes_table do
          row I18n.t('QRCode') do
            raw "<div style='border-left: 25px solid #{resource.color_reference};margin-top:50px;margin-bottom:50px'>
            #{link_to image_tag(RQRCode::QRCode.new(resource.id, :size => 8, :level => :h).as_png.to_data_url),
                      admin_item_path(resource)}</div>"
          end
          row I18n.t('Label') do
            resource.label
          end
          row I18n.t('Description') do
            resource.description
          end
          bool_row I18n.t('IsRootItem') do
            resource.is_root
          end
          bool_row I18n.t('Enabled') do
            resource.enabled
          end
          row I18n.t('Color_Reference') do
            raw "<div style='background-color: #{resource.color_reference}; border: 2px solid black; width: 20px; height: 20px' title='#{resource.color_reference}'></div>"
          end
          row "#{t("Location")} - #{t('Latitude')} & #{t('Longitude')}" do
            #"#{resource.lat};#{resource.lng}"
            #Rails.application.secrets.google_maps_api_key
            if resource.lat && resource.lng
              raw "<img style='max-width:1080px !important;background-color: border: 2px solid #{resource.color_reference}' src=\"https://maps.googleapis.com/maps/api/staticmap?center=#{resource.lat},#{resource.lng}&zoom=17&size=540x350&maptype=street&markers=color:blue|#{resource.lat},#{resource.lng}&key=#{Rails.application.secrets.google_maps_api_key}\"/>"
            else
              raw "<div style='background-color: border: 2px solid #{resource.color_reference};' title='#{resource.color_reference}'>
                    </div>"
            end
          end
          row I18n.t('Created_at') do
            resource.created_at
          end
          row I18n.t('Updated_at') do
            resource.updated_at
          end
        end
      end
      tab I18n.t('Associations') do
        panel I18n.t('Parents') do
          item.parents.each do |parent|
            if parent.nil?
              ''
            else
              attributes_table_for resource do
                row I18n.t('Item') do
                  (a(parent.label, href: admin_item_path(parent), class: 'attachment-link', target: '_blank'))
                end
                nil
              end
            end
          end
        end
        panel I18n.t('Children') do
          item.children.each do |child|
            if child.nil?
              ''
            else
              attributes_table_for resource do
                row I18n.t('Item') do
                  (a(child.label, href: admin_item_path(child), class: 'attachment-link', target: '_blank'))
                end
                nil
              end
            end
          end
        end
      end
      tab I18n.t('Attachments') do
        panel I18n.t('Attachments') do
          if (!item.attachments.nil?)
            table_for item.attachments do |att|
              att.column :path do |doc|
                a(build_label(doc.path.file.original_filename), href: doc.path, class: 'attachment-link', target: '_blank')
              end
              att.column I18n.t('Description'), :path do |doc|
                doc.path.file.original_filename
              end
              column I18n.t('created_at'), :created_at
              column I18n.t('updated_at'), :updated_at
            end
          end
        end
      end
    end
  end

  form do |f|
    # within @head do
    #   script src: 'https://api-maps.yandex.ru/2.1/?lang=es&load=Map,Placemark', type: 'text/javascript'
    # end
    f.actions do
      f.action :submit, label: I18n.t('save')
      cancel_link
    end
    tabs do
      tab I18n.t('Item_Details') do
        f.inputs I18n.t('Item_Details') do
          f.input :label, as: :string, label: I18n.t('Label')
          # f.input :country, as: :select, include_blank: false, label: I18n.t('Country'), collection: CountryStateSelect.countries_collection
          # f.input :state, as: :select, include_blank: false, label: I18n.t('State'), options: CountryStateSelect.state_options(form: f, field_names: { country: :country, state: :state })
          # f.input :city, as: :select, include_blank: false, options: CountryStateSelect.city_options(form: f, field_names: {  :state => :state, :city => :city })
          #http://nominatim.openstreetmap.org/search?q=Mexico,Aguascalientes&format=json
          f.input :description, label: I18n.t('Description')
          f.input :color_reference, as: :color, label: I18n.t('Color_Reference'), input_html: { style: 'width: 10%;height: 40px'}
          f.input :lat, label: I18n.t('Latitude')
          f.input :lng, label: I18n.t('Longitude')
          #f.latlng lang: :es, map: :yandex, id_lat: 'item_lat', id_lng: 'item_lng', start_lat: Rails.application.secrets.start_lat, start_lng: Rails.application.secrets.start_lng, loading_map: false
          f.latlng lang: :es, map: :google, id_lat: 'item_lat', id_lng: 'item_lng',
                   start_lat: Rails.application.secrets.start_lat, start_lng: Rails.application.secrets.start_lng,
                   loading_map: true,
                   api_key: Rails.application.secrets.google_maps_api_key
          f.input :enabled, label: I18n.t('Enabled')
        end
      end
      tab I18n.t('Associations') do
        f.inputs do
          f.input :is_root, label: I18n.t('IsRootItem')
          f.input :children, as: :select, collection: Item.where.not(id: item.id).pluck(:label, :id), label: I18n.t('Children'), include_blank: false, input_html: {class: 'select2'}
          f.input :parents, as: :select, collection: Item.where.not(id: item.id).pluck(:label, :id), label: I18n.t('Parents'), include_blank: false, input_html: {class: 'select2'}
          f.input :categories, as: :select, label: I18n.t('Categories'), include_blank: false, input_html: {class: 'select2'}
        end
      end
      if !f.object.new_record?
        tab I18n.t('Attachments') do
          f.has_many :attachments, heading: false, allow_destroy: true, as: :grid do |ff|
            ff.input :path, label: I18n.t('Attachment'), as: :file, hint:
                (ff.object.path.present? ?
                     ((%w(jpg jpeg gif png).map {|r| ff.object.path.url.include?(r)}.inject(&:|)) ?
                          image_tag(ff.object.path.url, class: 'thumbnail')
                          :
                          build_hint_file(ff.object.path.file.original_filename, ff.object.path))
                     :
                     content_tag(:span, I18n.t('no_file')))
          end
        end
      end
    end
  end

  controller do
    def permitted_params
      params.permit!
    end

    def create
      super do |format|
        redirect_to edit_admin_item_path(resource.id), alert: "#{I18n.t('Now_You_Can_add_files')} #{resource.label}" and return if resource.valid?
      end
    end

  end

  member_action :pdf, method: :get do
    render(pdf: "item-#{resource.id}.pdf")
  end

  action_item :view, only: [:show, :edit] do
    link_to I18n.t('Print'), "#{admin_item_path(resource)}/pdf", target: '_blank'
  end

  # actions defaults: false do |item|
  #   #link_to I18n.t('Print'), "#{admin_item_path(resource)}/pdf", target: '_blank'
  # end

end