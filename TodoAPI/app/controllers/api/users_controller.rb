module Api
  class UsersController < ApiController
    skip_before_filter :restrict_access

    # POST /users/signup
    def signup
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: {messages: user.errors.angular_growl_messages}, status: :bad_request
      end
    end

    # POST /users/login
    def login
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        render json: user, status: :ok
      else
        render json: {messages: [{text: "Incorrect email or password", severity: "error"}]}, status: 400
      end
    end

    # PATCH/PUT /users/reset_api_key
    def reset_api_key
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        user.reset_api_key
        render json: user.as_json(nil).merge(messages: [{text: 'API key reset successfully.', severity: 'info'}]), status: :ok
      else
        render json: {messages: [{text: "Incorrect email or password", severity: "error"}]}, status: 400
      end
    end

    # PATCH/PUT /users/change_password
    def change_password
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:old_password])
        if user.update(password: params[:new_password])
          render json: user.as_json(nil).merge(messages: [{text: 'Password changed successfully.', severity: 'info'}]), status: :ok
        else
          render json: {messages: user.errors.angular_growl_messages}, status: :bad_request
        end
      else
        render json: {messages: [{text: "Incorrect email or password", severity: "error"}]}, status: 400
      end
    end


    private

    def user_params
      params.permit(:email, :password)
    end
  end
end