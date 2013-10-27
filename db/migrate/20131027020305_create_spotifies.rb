class CreateSpotifies < ActiveRecord::Migration
  def change
    create_table :spotifies do |t|
      t.references :user, index: true
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
