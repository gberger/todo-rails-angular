require 'spec_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  it "should have a safe json representation" do
    json = @user.as_json(nil)
    expect(json[:password]).to be_nil
    expect(json[:password_digest]).to be_nil
  end
end
