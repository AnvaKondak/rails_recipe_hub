class RemoveAttachmentFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :attachment, :string
  end
end
