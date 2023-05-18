class TennisCourt < ApplicationRecord
  has_one_attached :image
  has_many :reviews
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
