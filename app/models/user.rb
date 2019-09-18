class User < ApplicationRecord
    has_secure_password
    has_many :comments, dependent: :nullify
    has_many :discussions, dependent: :nullify
    has_many :products, dependent: :nullify
    has_many :projects, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :tasks, dependent: :nullify
    has_many :newsarticles, dependent: :nullify
    has_many :likes
    has_many :liked_reviews, through: :likes, source: :review
    has_many :favourites
    has_many :favourited_products, through: :favourites, source: :product
    validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    def full_name
        "#{first_name} #{last_name}".strip
    end
end
