ActiveAdmin.register AdminUser do
  menu parent: "Configuration", priority: 1

  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    actions
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
