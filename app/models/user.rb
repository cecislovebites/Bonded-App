class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :groups, class_name: "Group", foreign_key: "user_id"
  has_many :posts, dependent: :destroy, class_name: "Posts"
  has_many :messages
  has_one_attached :photo
  validates_presence_of :first_name, :last_name, :email, :age, :about, :location
  validates :about, length: { minimum: 5 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :usergroups

  def self.search(location, age, gender)
    where("location ILIKE ? and age ILIKE ? and gender LIKE ?", "%#{location}%", "%#{age}%", "%#{gender}%")
    # where("location ILIKE ? AND age ? AND gender ?", "%#{location}%", "#{age}", "#{gender}")
  end
end
