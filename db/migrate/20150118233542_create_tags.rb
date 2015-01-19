class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :topic_id
      t.integer :publication_id
    end
  end
end
