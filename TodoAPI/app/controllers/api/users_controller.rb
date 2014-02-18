module Api
  class UsersController < ApiController
    skip_before_filter :restrict_access

    # POST /users
    # POST /users.json
    def create
      user = User.new(user_params)
      if user.save
        key = ApiKey.create(user_id: user.id)
        render json: {api_key: key, user: user}, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end