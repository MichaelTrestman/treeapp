module PublicationsHelper
  def complex_searchx(filters_hash={}, sort_order='alpha')
    Publication.includes(:authors)
  end

  def complex_search(filters_hash={}, sort_order='alpha')

    query_select = "SELECT publications.title, publications.id, publications.year, publications.citation_count, authors.last_name, authors.id"
    query_from = " FROM publications, authorships, authors"
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
    query_order = " ORDER BY " + set_sort_order(sort_order)
    # query_terms[:sort_order] =  'title asc' #set_sort_order(sort_order)
    query = [query_select, query_from, query_where, query_order].join(' ')
    p "find_by_sql(#{query}, #{query_terms})"

    results = find_by_sql([query, query_terms])
#
    # Publication.includes(:authorships, :authors).where(['title ILIKE :title AND author.last_name ILIKE :last_name'], {:title => "consciousness", last_name => 'consciousness'}])

    # ActiveRecord::Base.connection.execute(query, query_terms)
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
    sort_orders[order] || "title"

  end

end