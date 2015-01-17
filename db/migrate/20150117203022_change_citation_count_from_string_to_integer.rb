class ChangeCitationCountFromStringToInteger < ActiveRecord::Migration

  def change
    remove_column(:publications, :citation_count)
    add_column(:publications, :citation_count, :integer)
  end
end
