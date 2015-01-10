class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  # GET /publications
  # GET /publications.json
  def index

    query_string = ""

    if params[:title] && params[:title] != ""
        query_string += '
        (title LIKE :title_downcase
        OR
        title LIKE :title_capitalize
        OR
        title LIKE :title_upcase)
        '
    end


    if params[:date] && params[:date] != ""

      query_string += "AND " if query_string != ""

      query_string += 'date LIKE :pub_date'
    end

    if query_string == ""
      @publications = Publication.all.order(:title)
    else
      @publications = Publication.where(query_string,
        title_downcase: "%#{params[:title].downcase}%",
        title_capitalize: "%#{params[:title].capitalize}%",
        title_upcase: "%#{params[:title].upcase}%",
        pub_date: "%#{params[:date]}%"
      ).order(:title)
    end


    if params[:author] && params[:author] != ""
      author_queries = params[:author].split(' ')
      author_queries.each do |query|
        @publications = @publications
          .select{ |pub|
            pub.authors.any? { |auth|
              # auth.first_name == query.capitalize

              auth.last_name == query.capitalize
            }
          }
      end
    end
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @authors = @publication.authors
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: 'Publication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:title, :date)
    end
end
