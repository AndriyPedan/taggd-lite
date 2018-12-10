class Media < ApplicationRecord
  belongs_to :retailer

  enum status: { pending: 0, active: 1, rejected: 2 }

  scope :image, -> { where(type: 'Image') }
  scope :video, -> { where(type: 'Video') }
  scope :carousel_album, -> { where(type: 'CarouselAlbum') }

  validates :instagram_id, uniqueness: true
end
