class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :picture, :string
  end
end
