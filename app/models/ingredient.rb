class Ingredient < ApplicationRecord
    belongs_to :recipe, counter_cache: true

    scope :with_name, ->(name) { where("ingredients.name ilike ?", "%#{name}%") }
end
