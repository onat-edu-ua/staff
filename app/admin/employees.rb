ActiveAdmin.register Employee do
  menu parent: "Staff", priority: 1


  permit_params :first_name, :last_name, :middle_name, :department_id, :position_id, access_group_ids:[]

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
    column :access_groups do |c|
      c.access_groups_list
    end
    column :login
  end

  filter :id
  filter :fio_contains
  filter :login
  filter :department, input_html: { class: 'chosen' }
  filter :position, input_html: { class: 'chosen' }
  filter :access_group, as: :select, input_html: {class: 'chosen', multiple: true}, collection: -> { AccessGroup.collection }

  form do |f|
    f.inputs "Details" do
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :department, input_html: { class: 'chosen' }
      f.input :position, input_html: { class: 'chosen' }
      f.input :access_group_ids, label: "Access groups", as: :select, input_html: {class: 'chosen-sortable', multiple: true}, collection: AccessGroup.collection
    end
    f.actions
  end

  show do |s|
    attributes_table do
      row :id
      row :last_name
      row :first_name
      row :middle_name
      row :login do
        strong do
          s.login
        end
      end
      row :password do
        strong do
          s.password
        end
      end
      row :department
      row :position
      row :access_groups do
        s.access_groups_list
      end
    end
  end

end
