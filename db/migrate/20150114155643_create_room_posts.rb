class CreateRoomPosts < ActiveRecord::Migration
  def change
    create_table :room_posts do |t|
      t.integer :post_id
      t.integer :room_id

      t.references "post", index: true
      t.references "room", index: true

      t.timestamps null: false
    end
  end
end
