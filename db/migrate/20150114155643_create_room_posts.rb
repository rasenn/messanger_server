class CreateRoomPosts < ActiveRecord::Migration
  def change
    create_table :room_posts do |t|
      t.integer :post_id
      t.integer :room_id

      t.references "post", index: true, null: false
      t.references "room", index: true, null: true

      t.timestamps null: false
    end
  end
end
