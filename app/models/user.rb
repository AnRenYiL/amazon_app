class User < ApplicationRecord
    has_secure_password
    has_many :comment, dependent: :nullify
    has_many :discussion, dependent: :nullify
    has_many :product, dependent: :nullify
    has_many :project, dependent: :nullify
    has_many :review, dependent: :nullify
    has_many :task, dependent: :nullify
    has_many :newsarticle, dependent: :nullify
    validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    def full_name
        "#{first_name} #{last_name}".strip
    end
end
