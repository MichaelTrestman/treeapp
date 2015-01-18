module PublicationsHelper

  def complex_search(filters_hash={}, sort_order='alpha')
    search_object = self
    puts "^^^^^^^^^^^^^^^^^^"
    p filters_hash
    p sort_order
    sort_order = set_sort_order(sort_order)

    where_filters = ""

    where_terms = {
        title_downcase: "%#{ filters_hash[:title] || ''}%",
        author_lastname: "%#{ filters_hash[:author] || ""}%",
        date_start: filters_hash[:date_start].to_i  || '',
        date_end: filters_hash[:date_end].to_i || ""
      }

    if filters_hash[:title] && filters_hash[:title] != ""

      where_filters += " AND " unless where_filters.length == 0

      where_filters += "
        (title ILIKE :title_downcase)
      "

    end

    if filters_hash[:date_start] && filters_hash[:date_start] != ""
      where_filters += " AND " unless where_filters.length == 0
      where_filters += "(year >= :date_start)"
    end

    if filters_hash[:date_end] && filters_hash[:date_end] != ""
      where_filters += " AND " unless where_filters.length == 0
      where_filters += "(year <= :date_end)"
    end

    if filters_hash[:author] && filters_hash[:author] != ''

      #this will be a slowdown, cuz it has to run the query here and then again
      search_object = search_object.joins(:authors)

      where_filters += " AND " unless where_filters.length == 0
      where_filters += "
      (authors.last_name ILIKE :author_lastname)
      "
    end

    p "lllllllllllllll"
    p sort_order

    search_object.where(where_filters, where_terms).order(sort_order)
  end

  def set_sort_order order

   sort_orders = {
    'alpha' => {:title => :asc},
    'alpha-desc' => {:title => :desc},
    'citations' => {:citation_count => :asc},
    'citations-desc' => {:citation_count => :desc},
    'date' => {:date => :asc},
    'date-desc' => {:date => :desc}
    }

    sort_orders[order] || :title

  end

end