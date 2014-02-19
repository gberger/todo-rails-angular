module Api
  class SessionsController < ApiController
    skip_before_filter :restrict_access

    # POST /sessions
    # POST /sessions.json
    def create
      user = User.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        key = ApiKey.create(user_id: user.id)
        render json: {api_key: key, user: user}, status: :created
      else
        render json: {messages: [{text: "Incorrect email or password", severity: "error"}]}, status: 400
      end
    end

    # DELETE /sessions
    # DELETE /sessions.json
    def destroy
      current_api_key.destroy
      head :no_content
    end
  end
end
