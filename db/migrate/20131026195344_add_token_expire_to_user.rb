class AddTokenExpireToUser < ActiveRecord::Migration
  def change
    add_column :users, :token_expire, :datetime
  end
end
