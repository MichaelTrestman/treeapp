module PublicationsHelper

  def complex_search filters_hash={}, sort_order=nil

    sort_order = set_sort_order(sort_order)

    query_string = ""
    where_filters = ""
    where_terms = {
        title_downcase: "%#{ filters_hash[:title] ? filters_hash[:title].downcase : ''}%",
        title_capitalize: "%#{ filters_hash[:title] ? filters_hash[:title].capitalize: ''}%",
        title_upcase: "%#{ filters_hash[:title] ? filters_hash[:title].upcase : ''}%",
        pub_date: "%#{ filters_hash[:date] ? filters_hash[:date]: '' }%"
      }

    if filters_hash['title'] && filters_hash['title'] != ""

      where_filters += " AND " unless query_string.length == 0

      where_filters += "
        (title LIKE :title_downcase
        OR
        title LIKE :title_capitalize
        OR
        title LIKE :title_upcase)
      "
      where_terms += "

      "
    end
    if filters_hash['date'] && filters_hash['date'] != ""
      where_filters += " AND " unless query_string.length == 0

      where_filters += "
      (date LIKE :pub_date)
      "
    end

    return Publication.where(where_filters, where_terms).order(sort_order)
      # query_string += where_filters
      # query_string += ", "
      # query_string += where_terms
      # query_string += ")"
      # query_string += ".sort(:#{sort_order})"

  end

  def set_sort_order order

   sort_orders = {
    'alpha' => :title,
    'citations' => :title,
    'date' => :date
    }

    sort_orders[order] ||= :title

  end
end
