class Recipe < ApplicationRecord
    scope :rated_more_than, ->(rate) { where("rate > ?", rate) }
    scope :with_ingredient, ->(ingredient) { where("ingredients ilike ?", "%#{ingredient}%") }

end
