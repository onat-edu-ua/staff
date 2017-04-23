ActiveAdmin.register EmailDomain do
  menu parent: "Configuration", priority: 3

  permit_params :domain

  index do
    selectable_column
    id_column
    actions
    column :domain
    column :active
  end

  filter :id
  filter :domain
  filter :active

  form do |f|
    f.inputs "Details" do
      f.input :domain
      f.input :active
    end
    f.actions
  end

end
