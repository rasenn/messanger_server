class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id, null: false
      t.integer :friend_id, null: false

      t.index :user_id
      t.index :friend_id
      t.index [:user_id, :friend_id], unique: true
      
      t.timestamps null: false
    end
  end
end
