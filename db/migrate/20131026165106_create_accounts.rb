class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.string :action
      t.string :provider
      t.string :token

      t.timestamps
    end
  end
end
