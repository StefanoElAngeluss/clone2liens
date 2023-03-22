class CreateListes < ActiveRecord::Migration[7.0]
  def change
    create_table :listes do |t|
      t.string :titre
      t.text :contenu
      t.boolean :completed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
