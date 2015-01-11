class AddCitationCountToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :citation_count, :string
  end
end
