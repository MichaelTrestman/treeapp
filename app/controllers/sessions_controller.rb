class SessionsController < ApplicationController
  def create
    contributor = Contributor.find_by(email: params[:email])
    if contributor && contributor.authenticate(params[:password])
      login contributor

    else
      render :json => {:errors => "Invalid email and password combination"}, :status => :unprocessable_entity
    end
  end

  def login contributor
    session[:contributor_id] = contributor.id
    session[:contributor_name] = contributor.name
    redirect_to root_path
  end

  def loginz
    @contributor = Contributor.new
    render partial: 'login'
  end

  def logout
    session.clear
    redirect_to root_path
  end

end
