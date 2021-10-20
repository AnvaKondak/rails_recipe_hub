class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.string :attachment
      t.string :ingredients
      t.text :instructions
      t.boolean :isPublic

      t.timestamps
    end
  end
end
