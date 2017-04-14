ActiveAdmin.register User do
  permit_params :name, :email, :password

  menu label: I18n.t('Users')

  index do
    title I18n.t('Users')
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs t('user_details') do
      f.input :name
      f.input :email
      f.input :password
    end
    f.actions
  end

end
