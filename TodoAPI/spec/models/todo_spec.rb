require 'spec_helper'

describe Todo do
  before(:each) do
    @user = create(:user)
    @todo = create(:todo, user: @user)
  end

  it "should belong to a user" do
    expect(@todo.user).to equal(@user)
  end
end
