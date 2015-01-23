class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :scientific_name
      t.string :common_name
      t.text :link_urls
    end
  end
end
