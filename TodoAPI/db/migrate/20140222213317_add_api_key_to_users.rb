class AddApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_key, :string
    add_column :users, :api_key_expires_at, :datetime
  end
end
