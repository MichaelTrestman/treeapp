previous_name = {}

File.open('db/biblio.txt').readlines.each do |line|


  lineAry = line.split('(')
  names = lineAry.shift
  lineAry = lineAry[0].split(')')
  date = lineAry.shift
  remainder = lineAry[0]
  # p names
  p date

  remainder = remainder.split('').slice(2, 9999).join('')
  title = remainder.split('.')[0]
  p title

  # unless names == '––– ' || names == 'Institute for Laboratory Animal Research '

  authors = []

  names = names.split(',').select{ |name| name != ' et al. '}.map{|name| name.gsub(' ', '').gsub('&', '')}


  puts "************"
  p previous_name

  if names[0].split('')[1] == "–"

    puts "$$$ what the fuck Akins"
    p previous_name

    authors << previous_name

  elsif names[0] == 'Institute for Laboratory Animal Research '.gsub(' ', '').gsub('&', '')

    previous_name = {
      first_name: 'The',
      last_name: names[0]
    }

    authors << previous_name.clone

  elsif names.length % 2 == 0

    while names.length > 0

      raise "fucked up number of name segments; names: #{names}" unless names.length % 2 == 0

      last_name = names.shift
      first_name = names.shift

      previous_name = {
        first_name: first_name,
        last_name: last_name
      }
      authors << previous_name.clone
    end
  end


  if Publication.where({title: title, date: date}).count > 0

    new_pub = Publication.where({
      title: title,
      date: date
    })[0]
    p ("found existing pub#{new_pub.title}")

  else

    new_pub = Publication.create({
      title: title,
      date: date
    })
    p "created new pub#{new_pub.title}"

  end

  authors.each do |author|

    if Author.where(author).count > 0
      this_author = Author.where(author)[0]
    else
      this_author = Author.create(author)
    end

    unless new_pub.authors.any? {|auth| this_author == auth }
      new_pub.authors << this_author
    end
  end
end


File.open('db/topic_seeds.txt').readlines.each do |line|
  lineArr = line.split(' ')
  if lineArr[0] == '*'
    lineArr.shift
    line = lineArr.join(' ')
    Topic.create({title: line}) unless Topic.where({title: line}).length > 0
  end
end


# require_relative "publication_seeds"

# def log_pubs pubs
#   pubs.each do |pub|
#     if Publication.where({title: pub[:title]}).count > 0
#       db_pub = Publication.where({title: pub[:title]})[0]
#     else
#       db_pub = Publication.create({
#         title: pub[:title],
#         date: pub[:publication_date]
#       })
#     end

#     pub[:authors].each do |auth|
#       this_author = {}
#       this_author[:name] = auth.split(',')
#       this_author[:last_name] = this_author[:name][0]
#       this_author[:first_name] = this_author[:name][1]

#       if db_pub.authors.any?{ |db_auth|
#         this_author[:first_name] + this_author[:last_name] == db_auth.first_name + db_auth.last_name
#       }
#         {message: 'author previously in list'}
#       elsif Author.any?{ |db_auth|
#         this_author[:first_name] + this_author[:last_name]  == db_auth.first_name + db_auth.last_name
#       }
#         new_author = Author.where({
#           first_name: this_author[:first_name],
#           last_name: this_author[:last_name]
#         })[0]
#         db_pub.authors << new_author
#         # new_author.publications << db_pub
#       else
#         new_author = Author.create({
#           first_name: this_author[:first_name],
#           last_name: this_author[:last_name]
#         })
#         db_pub.authors << new_author
#         # new_author.publications << db_pub
#       end
#     end
#   end
# end

# log_pubs $pub_seeds




