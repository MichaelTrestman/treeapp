class Author < ActiveRecord::Base
  extend AuthorsHelper
  has_many :authorships
  has_many :publications, through: :authorships
  def coauthors
    _coauthors = []
    self.publications.each do |pub|
      pub.authors.each do |author|
        _coauthors << author
      end
    end
    _coauthors = _coauthors.uniq
    _coauthors.delete(self)
    _coauthors
  end
end
