class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

    # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user_id)
    #includeは含まれてる全てのデータを検索しているその中で欲しいデータを書く
    #followingsの中にはfollowした１番のデータが入ってるけどfollowされた４番のデータはないのでfindでuser１の中のuser４の情報を引っ張ってきている
    followings.include?(User.find(user_id))
  end

  def self.guest
    find_or_create_by!(nickname: 'guestuser' ,email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.nickname = "guestuser"
    end
  end

end
