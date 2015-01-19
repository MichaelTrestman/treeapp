module TopicsHelper

  def complex_search(filters_hash={}, sort_order='alpha')

    search_object = self
    sort_order = set_sort_order(sort_order)

    where_filters = ""

    where_terms = {
      title: "%#{ filters_hash[:title] }%",
      author: "%#{ filters_hash[:author] }%"

    }



  end
  def set_sort_order order

   sort_orders = {
    'alpha' => {:title => :asc},
    'alpha-desc' => {:title => :desc},
    'publications-count' => {:publication_count => :asc},
    'publications-desc' => {:publication_count => :desc}
    }

    sort_orders[order] || :title

  end

  def related_pubs
    Publication.where("
        title ILIKE :title
      ", :title => "%#{self.title}%")
  end

end
