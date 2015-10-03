ActiveAdmin.register AccessGroup do
  menu parent: "Configuration", priority: 2

  permit_params :name, :tag

  index do
    selectable_column
    id_column
    actions
    column :name
    column :tag
  end

  filter :id
  filter :name
  filter :tag

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :tag
    end
    f.actions
  end

end
