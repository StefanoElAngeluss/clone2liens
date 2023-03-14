class CreateProjets < ActiveRecord::Migration[7.0]
  def change
    create_table :projets do |t|
      t.string :titre
      t.string :lien

      t.timestamps
    end
  end
end
