module PublicationsHelper

  def complex_search(filters_hash={}, sort_order='alpha')
    query_where = "
      publications.id = authorships.publication_id
      AND
      authors.id = authorships.author_id
    "
    query_terms = {}

    if filters_hash[:title] && filters_hash[:title] != ""

      query_where += " AND "
      query_where += "
        (publications.title ILIKE :pub_title)
      "
      query_terms[:pub_title] = "%#{filters_hash[:title]}%"
    end

    if filters_hash[:date_start] && filters_hash[:date_start] != ""
      query_where += " AND "
      query_where += "(publications.year >= :date_start)"
      query_terms[:date_start] = filters_hash[:date_start]
    end
    if filters_hash[:date_end] && filters_hash[:date_end] != ""
      query_where += " AND "
      query_where += "(publications.year <= :date_end)"
      query_terms[:date_end] = filters_hash[:date_end]
    end
    if filters_hash[:author] && filters_hash[:author] != ''
      query_where += " AND "
      query_where += "authors.last_name ILIKE :author_lastname"
      query_terms[:author_lastname] = "%#{filters_hash[:author]}%"
    end
    if filters_hash[:topic] && filters_hash[:topic] != ''
      query_where += " AND "
      query_where += "topics.title ILIKE :topic_title"
      query_terms[:topic_title] = "%#{filters_hash[:topic]}%"
    end

    query_order = set_sort_order(sort_order)

    join_args = [:authors, :topics]

    model_class = Publication

    model_class.joins(*join_args).where([query_where, query_terms]).order(set_sort_order sort_order)

  end

  def set_sort_order order

    sort_orders = {
      'alpha' => "title asc",
      'alpha-desc' => "title desc",
      'citations-desc' => 'citation_count desc',
      'citations' => 'citation_count asc',
      'date' => 'date asc',
      'date-desc' => 'date desc'
    }
    sort_orders[order] || :title

  end

end