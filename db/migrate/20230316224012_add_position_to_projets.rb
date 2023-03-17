class AddPositionToProjets < ActiveRecord::Migration[7.0]
  def change
    add_column :projets, :position, :integer
    Projet.order(:updated_at).each.with_index(1) do |projet, index|
      projet.update_column(:position, index)
    end
  end
end
