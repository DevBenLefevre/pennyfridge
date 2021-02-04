class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :author
      t.integer :rate
      t.string :difficulty
      t.string :budget
      t.string :preparation_time
      t.string :total_time
      t.integer :people_quantity
      t.string :author_tip
      t.string :ingredients, array: true
      t.string :name
      t.string :tags, array: true
      t.string :image
      t.integer :nb_comments
      t.string :cook_time

      t.timestamps
    end
  end
end
