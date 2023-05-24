class TennisCourt < ApplicationRecord
  has_one_attached :image
  has_many :reviews
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.looks(search, word)
    if search == "perfect_match"
      tennis_courts = self.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      tennis_courts = self.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      tennis_courts = self.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      tennis_courts = self.where("name LIKE?","%#{word}%")
    else
      tennis_courts = self.all
    end
    tennis_courts
  end
end
