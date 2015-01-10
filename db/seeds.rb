
File.open('db/biblio.txt').readlines.each do |line|

  previous_name ||= ""

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

  # unless names == '––– ' || names == 'Institute for Laboratory Animal Research '

  authors = []
  names = names.split(',').select{|name| name != ' et al. ' && name != 'InstituteforLaboratoryAnimalResearch'}.map{|name| name.gsub(' ', '').gsub('&', '')}
  p names[0]

  if names[0] == "--- " or names[0] == "---"

    authors << Author.where({
      first_name: previous_name[:first_name],
      last_name: previous_name[:last_name]
    })[0]

  elsif names == 'Institute for Laboratory Animal Research '
    authors << {
      first_name: 'The',
      last_name: names
    }
  else
    while names.length > 0
      unless names[0] == '___'
        # raise "fucked up number of name segments; names: #{names}" unless names.length % 2 == 0
        last_name = names.shift
        first_name = names.shift
        previous_name = {
          first_name: first_name,
          last_name: last_name
        }
        authors << {
          first_name: first_name,
          last_name: last_name
        }
      end
      puts authors
    end
    if Publication.where({title: title, date: date}).count < 0
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
        (auth.first_name == author[:first_name]) && (auth.last_name == author[:last_name])
      }
        thisAuth = Author.where({
          first_name: author[:first_name],
          last_name: author[:last_name]
        })
        if thisAuth.count < 0
          new_pub.authors << thisAuth[0]
        else
          new_pub.authors << Author.create({
            first_name: author[:first_name],
            last_name: author[:last_name]
          })
        end
      end
    end
  end
end

File.open('db/topic_seeds.txt').readlines.each do |line|
  lineArr = line.split(' ')
  if lineArr[0] == '*'
    lineArr.shift
    line = lineArr.join(' ')
    Topic.create({title: line}) unless Topic.where({title: line}).length
  end
end


require_relative "publication_seeds"

def log_pubs pubs
  pubs.each do |pub|
    if Publication.where({title: pub[:title]}).count > 0
      db_pub = Publication.where({title: pub[:title]})[0]
    else
      db_pub = Publication.create({
        title: pub[:title],
        date: pub[:publication_date]
      })
    end

    pub[:authors].each do |auth|
      this_author = {}
      this_author[:name] = auth.split(',')
      this_author[:last_name] = this_author[:name][0]
      this_author[:first_name] = this_author[:name][1]

      if db_pub.authors.any?{ |db_auth|
        this_author[:first_name] + this_author[:last_name] == db_auth.first_name + db_auth.last_name
      }
        {message: 'author previously in list'}
      elsif Author.any?{ |db_auth|
        this_author[:first_name] + this_author[:last_name]  == db_auth.first_name + db_auth.last_name
      }
        new_author = Author.where({
          first_name: this_author[:first_name],
          last_name: this_author[:last_name]
        })[0]
        db_pub.authors << new_author
        # new_author.publications << db_pub
      else
        new_author = Author.create({
          first_name: this_author[:first_name],
          last_name: this_author[:last_name]
        })
        db_pub.authors << new_author
        # new_author.publications << db_pub
      end
    end
  end
end

log_pubs $pub_seeds




