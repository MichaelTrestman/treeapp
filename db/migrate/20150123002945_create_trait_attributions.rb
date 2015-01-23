class CreateTraitAttributions < ActiveRecord::Migration
  def change
    create_table :trait_attributions do |t|
      t.integer :trait_id
      t.integer :taxon_id
      t.boolean :valence
      t.integer :publication_id
      t.text :reference
    end
  end
end
