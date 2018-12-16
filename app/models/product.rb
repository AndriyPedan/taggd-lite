class Product < ApplicationRecord
  belongs_to :media
  has_and_belongs_to_many :categories

  scope :persisted, -> { where.not(id: nil) }

  enum gender: %i[any male female]

  validates :name, :price, :currency, presence: true
end
