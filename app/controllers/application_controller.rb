class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      if !logged_in?
        redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo" 
      else
        @github = GithubService.new({ 'access_token' => session[:token] })
      end
    end

    def logged_in?
      !!session[:token]
    end
end
