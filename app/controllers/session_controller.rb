class SessionsController < ApplicationController
  def create
    contributor = Contributor.find_by(email: params[:email])
    if contributor && contributor.authenticate(params[:password])
      login contributor
      render json: { redirect: redirect_path }
    else
      render :json => {:errors => "Invalid email and password combination"}, :status => :unprocessable_entity
    end
  end

  def login

  end

  def logout
    session.clear
    redirect_to root_path
  end

end
