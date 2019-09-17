class Newsarticle < ApplicationRecord
    validates(:title, presence: true, uniqueness:  true)
    validates(:description, presence: true)
    validate :published_at_after_created_at
    before_save :titleize_title
    belongs_to :user
    def set_publish_time
        self.published_at = Time.now
        self.published_at
    end

    private

    def published_at_after_created_at
        if self.published_at && self.created_at && (self.published_at < self.created_at) 
            self.errors.add(:published_at,'must be after created_at')
        end
    end

    def titleize_title
        self.title = self.title.titlecase
    end
end
