ActiveAdmin.register Email do
  menu parent: "Staff", priority: 4

  permit_params :domain_id, :employee_id, :username, :password

  index do
    selectable_column
    id_column
    actions
    column "Employee" do |c|
      c.employee.try(:fio)
    end
    column :username
    column :domain
  end

  filter :id
  filter :domain
  filter :username

  form do |f|
    f.inputs "Details" do
      f.input :employee
      f.input :username
      f.input :domain
      f.input :password
    end
    f.actions
  end

end
