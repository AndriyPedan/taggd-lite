class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  has_and_belongs_to_many :products
end
