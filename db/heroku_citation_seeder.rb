
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
        pub = Publication.where({title: line[0], date: line[1]})[0]
        raise 'shit title thing aint right' unless pub
        raise 'citation count not integer' unless line[2].to_i.class == Fixnum
        pub.citation_count = line[2].to_i
        pub.save
      end
  end

end