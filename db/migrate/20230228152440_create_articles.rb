class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :titre
      t.text :contenu
      t.integer :views, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
