module AuthenticationConcern
  def current_contributor
    @current_contributor ||= Contributor.find(session[:contributor_id]) if session[:contributor_id]
  end

  def contributor_loggin_in?
    current_contributor.present?

  end
  def login contributor
    session[:contributor_id] = contributor.id
  end
  def logout
    session.clear
    authenticate_user!
  end
  def authenticate_user!
    redirect_to root_path unless current_contributor.present?
  end
end