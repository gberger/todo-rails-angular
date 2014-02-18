class ApiController < ApplicationController
  def current_user
    @current_user ||= (api_key = ApiKey.find_by_access_token(params[:access_token])) && !api_key.expired? && api_key.user
  end

  before_filter :restrict_access
  def restrict_access
    head :unauthorized unless !!current_user
  end
end