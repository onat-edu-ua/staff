ActiveAdmin.register Employee do
  permit_params :first_name, :last_name, :middle_name, :department_id, :position, :access_group_ids

  includes :department, :position

  index do
    selectable_column
    id_column
    actions
    column :last_name
    column :first_name
    column :middle_name
    column :department
    column :position
    column :login
  end

  filter :id
  filter :login
  filter :department, input_html: { class: 'chosen' }
  filter :position, input_html: { class: 'chosen' }

  form do |f|
    f.inputs "Details" do
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :department, input_html: { class: 'chosen' }
      f.input :position, input_html: { class: 'chosen' }
    end
    f.actions
  end

end
