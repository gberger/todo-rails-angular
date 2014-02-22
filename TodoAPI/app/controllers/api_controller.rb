class ApiController < ApplicationController
  def provided_api_key
    params[:access_token] || request.headers['AccessToken'] || params[:api_key] || request.headers['ApiKey'] || nil
  end

  def current_user
    puts provided_api_key
    @current_user ||= User.find_by_api_key(provided_api_key)
  end

  before_filter :restrict_access
  def restrict_access
    head :unauthorized unless !!current_user
  end
end