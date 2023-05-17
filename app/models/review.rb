class Review < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :tennis_court
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
