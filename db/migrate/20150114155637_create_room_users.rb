class CreateRoomUsers < ActiveRecord::Migration
  def change
    create_table :room_users do |t|
      t.integer :room_id
      t.integer :user_id

      t.references "room", index: true, null: false
      t.references "user", index: true, null: false

      t.timestamps null: false
    end
  end
end
