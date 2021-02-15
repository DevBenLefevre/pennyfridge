class Recipe < ApplicationRecord
    has_many :ingredients

    scope :rated_more_than, ->(rate) { where("rate >= ?", rate) }
    scope :with_ingredient, ->(ingredient) { where("ingredients ilike ?", "%#{ingredient}%") }
end
