module AuthorshipsHelper
  def dedupe
    grouped = Authorship.all.group_by{|x| [x.author_id, x.publication_id]}
    grouped.values.each do |dupes|
      one_to_save = dupes.pop
      dupes.each{|dupe| dupe.destroy}
    end
  end
end