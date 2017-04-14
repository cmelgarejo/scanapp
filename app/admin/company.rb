ActiveAdmin.register Company do
  permit_params :name, :description, :enabled

  menu label: I18n.t('Companies')
  #index title: I18n.t('Companies')

  index title: I18n.t('Companies') do
    selectable_column
    id_column
    column :name
    column :description
    column :enabled
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :description
  filter :enabled
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs t('Company_Details') do
      f.input :name
      f.input :description
      f.input :enabled
    end
    f.actions
  end

end