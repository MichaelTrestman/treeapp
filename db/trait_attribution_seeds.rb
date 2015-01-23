pub = Publication.all.select{|x|x.authors.any? {|z|z.last_name == 'Trestman'}}.first



