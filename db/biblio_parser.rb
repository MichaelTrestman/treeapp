'db/animal_consciousness_SEP_biblio.txt'
module Pub_and_Author_seeder
  def seed_from_biblio_txt file_path
    File.open(file_path).readlines.each do |line|

      previous_name = ""

      lineAry = line.split('(')
      names = lineAry.shift
      lineAry = lineAry[0].split(')')
      date = lineAry.shift
      remainder = lineAry[0]
      # p names
      p date
      raise 'pooballz' unless remainder.split('')[1] == ' '
      remainder = remainder.split('').slice(2, 9999).join
      title = remainder.split('.')[0]
      p title

      unless names == '––– ' || names == 'Institute for Laboratory Animal Research '
        names = names.split(',').select{|name| name != ' et al. ' && name != 'InstituteforLaboratoryAnimalResearch'}.map{|name| name.gsub(' ', '').gsub('&', '')}
        authors = []
        while names.length > 0
          raise "fucked up number of name segments; names: #{names}" unless names.length % 2 == 0
          last_name = names.shift
          first_name = names.shift
          authors << {
            first_name: first_name,
            last_name: last_name
          }
          puts authors
        end
        if Publication.where({title: title, date: date}).count
          new_pub = Publication.where({
            title: title,
            date: date
          })[0]
        else
          new_pub = Publication.create({
            title: title,
            date: date
          })
        end
        authors.each do |author|
          unless new_pub.authors.any? {|auth|
            (auth.first_name == author.first_name) && (auth.last_name == author.last_name)
          }
            thisAuth = Author.where({
              first_name: author.first_name,
              last_name: author.last_name
            })
            if thisAuth.count
              new_pub.authors << thisAuth[0]
            else
              new_pub.authors << Author.create({
                first_name: author.first_name,
                last_name: author.last_name
              })
            end
          end
        end
      end
    end
  end
end