class CreateRoomUsers < ActiveRecord::Migration
  def change
    create_table :room_users do |t|
      t.integer :room_id
      t.integer :user_id

      t.references "room", index: true
      t.references "user", index: true

      t.timestamps null: false
    end
  end
end
