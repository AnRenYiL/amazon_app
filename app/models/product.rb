class Product < ApplicationRecord
    has_many :reviews, dependent: :destroy
    belongs_to :user
    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    
    validates(:title, presence: true, uniqueness:  { case_sensitive: false })
    validates(
        :description,
            presence: {
            message: "must exist"
            },
            length: { minimum: 10 }
            )
    validates(:price, presence: true, numericality:{greater_than: 0})

    before_validation :set_default_price 
    before_save :capitalize_the_product

    private

    def set_default_price 
        if self.price
            self.price = self.price > 0 ? self.price : 1
        else
            self.price = 1
        end
    end

    def capitalize_the_product
      self.title.capitalize!
      
    end
    
end
