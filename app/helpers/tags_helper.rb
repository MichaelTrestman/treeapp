module TagsHelper
  def dedupe
    Tag.all.group_by{|x| [x.publication_id, x.topic.id]}.values.each do |dupes|
      one_to_save = dupes.pop
      dupes.each { |dupe| dupe.destroy }
    end
  end
end