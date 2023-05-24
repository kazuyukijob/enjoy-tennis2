class Review < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :tennis_court
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      reviews = self.where("review_title LIKE?","#{word}")
    elsif search == "forward_match"
      reviews = self.where("review_title LIKE?","#{word}%")
    elsif search == "backward_match"
      reviews = self.where("review_title LIKE?","%#{word}")
    elsif search == "partial_match"
      reviews = self.where("review_title LIKE?","%#{word}%")
    else
      reviews = self.all
    end
    reviews
  end
end
