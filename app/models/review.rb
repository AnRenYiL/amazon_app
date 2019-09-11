class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  # validates :body, presence: true
  # validates(:rating, presence: true, numericality:{greater_than: 0.99999, less_than: 5.0000001})
  validates :rating, presence: true
  validates_numericality_of(:rating, :only_integer =>true,:greater_than =>0,:less_than => 6,:message =>'rating should be integer and between 1 to 5')
end
