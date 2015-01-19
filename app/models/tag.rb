class Tag < ActiveRecord::Base
  belongs_to :topic, foreign_key: 'topic_id'
  belongs_to :publication, foreign_key: 'publication_id'

  def self.connect_topics_to_pubs
    Topic.find_each do |topic|

      related_pubs = Publication.where("
        title ILIKE :title
      ", :title => "%#{topic.title}%")

      related_pubs.find_each do |pub|
        pub.topics << topic
        pub.save
      end

    end

  end

end