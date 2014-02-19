class ApiController < ApplicationController
  def provided_access_token
    params[:access_token] || request.headers['AccessToken'] || nil
  end

  def current_user
    @current_user ||= !!current_api_key ? current_api_key.user : nil
  end

  def current_api_key
    @api_key ||= ApiKey.find_by_access_token(provided_access_token)
  end

  before_filter :restrict_access
  def restrict_access
    head :unauthorized unless !!current_user
  end
end