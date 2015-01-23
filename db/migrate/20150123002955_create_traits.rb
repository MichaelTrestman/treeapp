class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string :name
      t.text :description
      t.text :link_urls
    end
  end
end
