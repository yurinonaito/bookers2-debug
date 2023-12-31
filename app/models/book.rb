class Book < ApplicationRecord

  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :post_comments, dependent: :destroy
  
  has_many :view_counts, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("name LIKE?","%#{word}%")
    else
      @book = Book.all
    end
    
    scope :latest, -> { order(created_at: :desc) }
    scope :rating, -> {order(star: :desc)}
    
  end
  
  
end
