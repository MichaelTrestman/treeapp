class Topic < ActiveRecord::Base
  extend TopicsHelper
  has_many :tags
  has_many :publications, through: :tags
  def related_pubs
    Publication.where("
        title ILIKE :title
      ", :title => "%#{self.title}%")
  end
end
