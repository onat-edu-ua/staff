ActiveAdmin.register EmailDomain do
  menu parent: "Configuration", priority: 3

  permit_params :domain

  index do
    selectable_column
    id_column
    actions
    column :domain
  end

  filter :id
  filter :domain

  form do |f|
    f.inputs "Details" do
      f.input :domain
    end
    f.actions
  end

end
