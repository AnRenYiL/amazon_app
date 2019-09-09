class Project < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_many :discussions, dependent: :destroy
end
