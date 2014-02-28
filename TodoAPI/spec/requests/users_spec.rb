require 'spec_helper'

describe "Users" do
  before(:each) do
    @password = 'pass1234'
    @user = create(:user, password: @password)
  end

  describe "POST /api/users/signup" do
    it "allows registration of a new user" do
      expect { post api_users_signup_path, attributes_for(:user) }
      .to change { User.count }.by(1)
    end

    it "validates duplicate emails" do
      post api_users_signup_path, {email: @user.email, password: @password}
      expect(response.status).to eq(400)
    end

    it "validates short passwords" do
      post api_users_signup_path, attributes_for(:user_with_short_password)
      expect(response.status).to eq(400)
    end
  end

  describe "POST /api/users/login" do
    it "denies access with bad credentials" do
      post api_users_login_path, attributes_for(:user)
      expect(response.status).to eq(400)
    end

    it "allows access with good credentials" do
      post api_users_login_path, {email: @user.email, password: @password}
      expect(response.status).to eq(200)
    end
  end

  describe "GET /api/users/me" do
    it "allows access with correct ApiKey header" do
      get api_users_me_path, nil, { 'ApiKey' => @user.api_key }
      expect(response.status).to eq(200)
      expect(json['email']).to eq(@user.email)
    end

    it "allows access with correct AccessToken header" do
      get api_users_me_path, nil, { 'AccessToken' => @user.api_key }
      expect(response.status).to eq(200)
      expect(json['email']).to eq(@user.email)
    end

    it "allows access with correct api_key param" do
      get api_users_me_path, { api_key: @user.api_key }
      expect(response.status).to eq(200)
      expect(json['email']).to eq(@user.email)
    end

    it "allows access with correct access_token param" do
      get api_users_me_path, { access_token: @user.api_key }
      expect(response.status).to eq(200)
      expect(json['email']).to eq(@user.email)
    end
  end

  describe "PATCH/PUT /api/users/reset_api_key" do
    it "denies access with bad credentials" do
      put api_users_reset_api_key_path, attributes_for(:user)
      expect(response.status).to eq(400)
    end

    it "allows access with good credentials" do
      put api_users_reset_api_key_path, {email: @user.email, password: @password}
      expect(response.status).to eq(200)
    end

    it "generates a new API key" do
      expect { put api_users_reset_api_key_path, { email: @user.email, password: @password } }
      .to change{ User.find(@user.id).api_key }
    end
  end


  describe "PATCH/PUT /api/users/change_password" do
    it "resets the password" do
      expect { put api_users_change_password_path, { email: @user.email, old_password: @password, new_password: "the_new123"} }
      .to change{ User.find(@user.id).password_digest }
    end
  end

end
