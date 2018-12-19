ActiveAdmin.register Category do
  permit_params :name, :parent_id
end
