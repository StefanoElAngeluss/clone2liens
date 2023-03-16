class CreateProduits < ActiveRecord::Migration[7.0]
  def change
    create_table :produits do |t|
      t.string :nom
      t.text :description
      t.decimal :price, precision: 5, scale: 2

      t.timestamps
    end
  end
end
