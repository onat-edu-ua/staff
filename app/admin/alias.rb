ActiveAdmin.register Alias do
  menu parent: "Staff"
  permit_params :dst, :rewrite_dst, :description

  index do
    selectable_column
    column "Alias", :dst
    column "Destination", :rewrite_dst
    column :created_at
    column :updated_at
    column :description
    actions
  end

  filter :dst, label: "Alias"
  filter :rewrite_dst, label: "Destination"
  filter :description 

  form do |f|
    f.inputs "Details" do
      f.input :dst, label: "Alias", hint: "As seen in \"To:\" field"
      f.input :rewrite_dst, label: "Destination", hint: "Where to route an email"
      f.input :description
    end
    f.actions
  end
end
