class Discussion < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :comments, dependent: :destroy
end
