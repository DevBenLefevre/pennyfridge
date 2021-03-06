class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :author
      t.integer :rate
      t.string :difficulty
      t.string :budget
      t.string :prep_time
      t.string :total_time
      t.integer :people_quantity
      t.string :author_tip
      t.string :ingredients
      t.string :name
      t.string :tags, array: true
      t.string :image
      t.integer :nb_comments
      t.string :cook_time

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
