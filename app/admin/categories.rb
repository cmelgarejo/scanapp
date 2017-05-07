ActiveAdmin.register Category do
  permit_params :name, :description
  actions :all, :except => [:show]

  menu label: I18n.t('Categories')

  index do
    title I18n.t('Categories')
    selectable_column
    id_column
    column I18n.t('Label') do |company|
      link_to company.name, edit_admin_category_path(company)
    end
    column :description
    column :created_at
    actions
  end

  filter :name
  filter :description
  filter :created_at

  form do |f|
    f.inputs t('category_details') do
      f.input :name
      f.input :description
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

end
