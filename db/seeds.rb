
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




