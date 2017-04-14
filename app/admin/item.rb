ActiveAdmin.register Item do
  permit_params :label, :description, :color_reference, :picture, :lat, :lng, :enabled, :is_template, :is_root, :properties
  # :qrcode,
  # :company,
  # :item

  menu label: I18n.t('Items') do
  end

  index title: I18n.t('Items') do
    selectable_column
    id_column
    column :label
    column :description
    bool_column :enabled
    column :created_at
    column :updated_at
    actions
  end

  filter :label
  filter :description
  filter :enabled
  filter :created_at
  filter :updated_at

  show title: I18n.t('Items') do
    attributes_table do
      row :label
      row :description
      bool_row :enabled
      #color_row :color_reference
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs t('Item_Details') do
      f.input :label
      f.input :description
      #f.input :color_reference, as: :color_picker
      f.input :color_reference, as: :color_picker, palette: ["#DD2900","#D94000","#D55500","#D26A00","#CE7D00","#CA9000","#C6A300","#C2B400","#B9BF00"]
      f.input :lat
      f.input :lng
      f.latlng lang: :es, map: :yandex, id_lng: 'item_lng'# add this
      f.input :enabled
    end
    f.actions
  end

end