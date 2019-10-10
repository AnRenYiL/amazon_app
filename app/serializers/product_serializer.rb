class ProductSerializer < ActiveModel::Serializer
  attributes(:id, :title, :description, :created_at, :updated_at,:price)
  belongs_to :user, key: :seller
  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating
  end 
end
