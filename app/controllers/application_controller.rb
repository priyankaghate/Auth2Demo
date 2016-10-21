class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def doorkeeper_unauthorized_render_options(error: nil)
	   { json: { error: "Not authorized" } }
    end

    def new_oauth_token_path(params)
	  "http://localhost:3000/oauth/authorize?client_id=#{params['client_id']}&redirect_uri=#{ENV['oauth_redirect_uri']}&response_type=code&scope=public+write"
	end

	

  private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	helper_method :current_user
	
end
