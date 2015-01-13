module PublicationsHelper

  def complexSearch filters_hash={}, order=nil

    sort_order = set_sort_order order

    query_string = self.name
    query_string += ".where("

    where_filters = ""
    where_terms = ""
    if filters_hash['title'] && filters_hash['title'] != ""

      query_string += "
        (title LIKE :title_downcase
        OR
        title LIKE :title_capitalize
        OR
        title LIKE :title_upcase)
      "

    end
      query_string += where_filters
      query_string += ", "
      query_string += where_terms
      query_string += ")"
      query_string += ".sort(:#{sort_order})"

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
