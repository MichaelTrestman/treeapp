class AddAbstractFullTextAndLinksToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :abstract, :text
    add_column :publications, :body, :text
    add_column :publications, :bibliography, :text
    add_column :publications, :url, :text
  end
end
