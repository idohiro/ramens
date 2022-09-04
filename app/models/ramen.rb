class Ramen < ApplicationRecord

belongs_to :customers,optional: true
has_many :favorites, dependent: :destroy
has_many :ramen_comments, dependent: :destroy
validates :name, presence: true
validates :shop_name, presence: true
validates :introduction, presence: true
validates :price, presence: true

  has_one_attached :ramen_image

  def favorited?(customer)
   favorites.where(customer_id: customer.id).exists?
  end


  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end


    # def get_ramen_image(width, height)
    #   (ramen_image.attached?) ? ramen_image : 'sample.jpeg'
    # end

end
