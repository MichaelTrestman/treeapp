class Tag < ActiveRecord::Base
  extend TagsHelper
  belongs_to :topic, foreign_key: 'topic_id'
  belongs_to :publication, foreign_key: 'publication_id'

  def self.prune_redundant
    Topic.all.each do |topic|
      topic_tags = []
      topic.tags.each{|tag| topic_tags << tag }
      topic_tags.each_with_index do |tag, i|
        j = i
        until (topic_tags[j].nil? || tag.nil?)
          return if topic_tags[j].nil?
          next if tag.nil?
          j += 1
          puts "(((((((((((((("
            p tag
          raise "tag is nil" if tag.nil?
          raise "topic_tag[j] is nil" if topic_tags[j].nil?
          topic_tags[j].delete if tag.publication_id == topic_tags[j].publication_id

        end
      end
    end
  end
  def self.connect_topics_to_pubs
    Topic.find_each do |topic|

      related_pubs = Publication.where("
        (title ILIKE :topic_title)
        or
        (abstract ILIKE :topic_title)
      ", :topic_title => "%#{topic.title}%")

      related_pubs.find_each do |pub|
        pub.topics << topic unless pub.topics.include?(topic)
        pub.save
      end

    end

  end

end