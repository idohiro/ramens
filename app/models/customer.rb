class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ramens, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :ramen_comments, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
   validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

 def follow(customer_id)
    relationships.create(followed_id: customer_id)
 end


 def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
 end

 def following?(customer)
    followings.include?(customer)
 end

   def self.search_for(content, method)
    if method == 'perfect'
      Customer.where(name: content)
    elsif method == 'forward'
      Customer.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Customer.where('name LIKE ?', '%' + content)
    else
      Customer.where('name LIKE ?', '%' + content + '%')
    end
   end

end
