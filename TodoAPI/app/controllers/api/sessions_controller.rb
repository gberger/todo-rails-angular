module Api
  class SessionsController < ApiController
    skip_before_filter :restrict_access

    # POST /sessions
    # POST /sessions.json
    def create
      user = User.find_by_email(params[:user][:email])
      puts user
      if user && user.authenticate(params[:user][:password])
        key = ApiKey.create(user_id: user.id)
        render json: {api_key: key, user: user}, status: :created
      else
        head :unauthorized
      end
    end
  end
end