ActiveAdmin.register Item do
  permit_params :label, :description, :color_reference, :picture, :lat, :lng, :enabled, :is_template, :is_root, :extra_properties, :attachment_attributes, :path
  # :qrcode,
  # :company,
  # :item

  index do
    selectable_column
    #id_column
    column I18n.t('Label') do |item|
      link_to item.label, admin_item_path(item)
    end
    column I18n.t('QRCode') do |item|
      link_to image_tag(RQRCode::QRCode.new(item.id, :size => 8, :level => :h).as_png.to_data_url), admin_item_path(item)
    end
    column I18n.t('Description'), :description
    column I18n.t('Color_Reference'), :color_reference
    bool_column I18n.t('Enabled'), :enabled
    column I18n.t('Created_at'), :created_at
    column I18n.t('Updated_at'), :updated_at
    actions
  end

  filter :label
  filter :description
  filter :enabled
  filter :created_at
  filter :updated_at

  show do
    tabs do
      tab I18n.t('Item_Details') do
        attributes_table do
          row I18n.t('QRCode') do
            image_tag RQRCode::QRCode.new(resource.id, :size => 8, :level => :h).as_png.to_data_url
          end
          row I18n.t('Label') do
            resource.label
          end
          row I18n.t('Description') do
            resource.description
          end
          bool_row I18n.t('Enabled') do
            resource.enabled
          end
          row I18n.t('Color_Reference') do
            resource.color_reference
          end
          row "#{t('Latitude')} & #{t('Longitude')}" do
            "#{resource.lat};#{resource.lng}"
          end
          row I18n.t('Created_at') do
            resource.created_at
          end
          row I18n.t('Updated_at') do
            resource.updated_at
          end
        end
      end
      tab I18n.t('Attachments') do
        #DO A ERB OR ARB PARTIAL
        panel I18n.t('Attachments') do
          attributes_table_for resource do
            row 'Tags' do
              item.attachment.each do |att|
                image_column
                #link_to(att.path.file.original_filename, att.path.file.path, target: "_blank", class: "attachment-link")
                a att.path.file.original_filename, href: att.path.file.path, class: 'attachment-link'
                text_node "&nbsp;".html_safe
              end
            end
          end
        end
        # p = resource.attachment.each do |att|
        #   puts link_to(att.path.file.original_filename, att.path.file.path, target: "_blank", class: "attachment-link")
        # end
        # puts p.map(&:path).inject(arr) { |s, e| link_to s }
        #p.join("<br />").html_safe
        #link_to(resource.attachment.map(&:path).map(&:file).map(&:original_filename)).html_safe
        #resource.attachment.map(&:path).join("<br />").html_safe
      end
    end
  end

  form do |f|
    f.actions do
      f.action :submit, label: I18n.t('save')
      cancel_link
    end
    tabs do
      tab I18n.t('Item_Details') do
        f.inputs I18n.t('Item_Details') do
          f.input :label, as: :string, label: I18n.t('Label')
          f.input :description, label: I18n.t('Description')
          f.input :color_reference, as: :color_picker, label: I18n.t('Color_Reference')
          f.input :lat, label: I18n.t('Latitude')
          f.input :lng, label: I18n.t('Longitude')
          f.latlng lang: :es, map: :yandex, id_lng: 'item_lng', start_lat: Rails.application.secrets.start_lat, start_lng: Rails.application.secrets.start_lng # add this
          f.input :enabled, label: I18n.t('Enabled')
        end
      end
      tab I18n.t('Attachments') do
        f.has_many :attachment, heading: false, allow_destroy: true, as: :grid do |ff|
          ff.input :path, label: I18n.t('Attachment'), as: :file, :hint => ff.object.path.present? ? image_tag(ff.object.path.url, class: 'thumbnail') : content_tag(:span, I18n.t('no_file'))
        end
      end
    end
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

end