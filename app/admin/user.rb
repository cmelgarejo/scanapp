ActiveAdmin.register User do
  permit_params :name, :email, :password

  menu label: I18n.t('Users')

  index do
    title I18n.t('Users')
    selectable_column
    id_column
    column I18n.t('Name') do |item|
      link_to item.name, admin_user_path(item)
    end
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :company
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  # show do
  #   tabs do
  #     tab I18n.t('User_Details') do
  #       attributes_table do
  #         row I18n.t('Name') do
  #           image_tag RQRCode::QRCode.new(resource.id, :size => 8, :level => :h).as_png.to_data_url
  #         end
  #         row I18n.t('Label') do
  #           resource.label
  #         end
  #         row I18n.t('Description') do
  #           resource.description
  #         end
  #         bool_row I18n.t('Enabled') do
  #           resource.enabled
  #         end
  #         row I18n.t('Color_Reference') do
  #           resource.color_reference
  #         end
  #         row "#{t('Latitude')} & #{t('Longitude')}" do
  #           "#{resource.lat};#{resource.lng}"
  #         end
  #         row I18n.t('Created_at') do
  #           resource.created_at
  #         end
  #         row I18n.t('Updated_at') do
  #           resource.updated_at
  #         end
  #       end
  #     end
  #   end
  # end

  form do |f|
    f.inputs t('user_details') do
      f.input :name
      f.input :email
      f.input :password
      f.input :company_id, as: :select, collection: Company.all
    end
    f.actions
  end

end
