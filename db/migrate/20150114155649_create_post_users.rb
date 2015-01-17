class CreatePostUsers < ActiveRecord::Migration
  def change
    create_table :post_users do |t|
      t.integer :post_id
      t.integer :user_id

      t.references "post", index: true, null: false
      t.references "user", index: true, null: false

      t.timestamps null: false
    end
  end
end
