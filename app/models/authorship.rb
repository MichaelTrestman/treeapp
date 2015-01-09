class Authorship < ActiveRecord::Base

  belongs_to :author, foreign_key: 'author_id'
  belongs_to :publication, foreign_key: 'publication_id'

end