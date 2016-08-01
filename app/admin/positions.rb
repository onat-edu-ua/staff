ActiveAdmin.register EmployeePosition do
  menu parent: "Staff", priority: 2

  permit_params :name

  index do
    selectable_column
    id_column
    actions
    column :name
  end

  filter :id
  filter :name

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.actions
  end

end