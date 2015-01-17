
module SearchHelper

  def complex_search(filters_hash, sort_order=nil)

    sort_order = set_sort_order(sort_order)
    puts "************"
    p 'sort order:'
    p sort_order
    p "filters_hash"
    p filters_hash

    where_filters = ""

    where_terms = {
        title_downcase: "%#{ filters_hash[:title] || ''}%",
        pub_date: "%#{ filters_hash[:date] ? filters_hash[:date]: '' }%"
      }

    # if filters_hash[:authors] && filters_hash
    if filters_hash[:title] && filters_hash[:title] != ""

      where_filters += " AND " unless where_filters.length == 0

      where_filters += "
        (title ILIKE :title_downcase)
      "
    end

    if filters_hash[:date] && filters_hash[:date] != ""
      where_filters += " AND " unless where_filters.length == 0
      where_filters += "
      (date LIKE :pub_date)
      "
    end
    puts "$$$$$$$$$$$$$$$$$$$$$"

    results = self.where(where_filters, where_terms).order(sort_order)
    p 'results length:'
    p results.count
    p results
    results
  end

  def set_sort_order order

   sort_orders = {
    'alpha' => :title,
    'citations' => :citations,
    'date' => :date
    }

    sort_orders[order] ||= :title

  end
end
