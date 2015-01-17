
class HerokuCitationSeeder
  def initialize
    @publications = Publication.all
  end

  def create_seed_txt
    seed_txt = File.open('db/citation_count_seed.txt', "w")
    @publications.each do |pub|
      seed_txt.puts "#{pub.title}|#{pub.date}|#{pub.citation_count}"
    end
    seed_txt.close
    puts 'something?'
  end
  def seed_from_txt
    seed_txt = File.open('db/citation_count_seed.txt', 'r')
      seed_txt.each do |line|
        line = line.gsub("\n", '').split('|')
        Publication.where({title: line[0], date: line[1]})[0].citation_count = line[2]
      end
  end

end