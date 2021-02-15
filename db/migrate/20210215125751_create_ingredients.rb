class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe
      t.string :ingredient

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end

    remove_column :recipes, :ingredients, :string
  end
end
