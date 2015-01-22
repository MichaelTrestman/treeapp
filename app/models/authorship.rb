class Authorship < ActiveRecord::Base
  extend AuthorshipsHelper
  belongs_to :author, foreign_key: 'author_id'
  belongs_to :publication, foreign_key: 'publication_id'

end