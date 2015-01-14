class CreatePostUsers < ActiveRecord::Migration
  def change
    create_table :post_users do |t|
      t.integer :post_id
      t.integer :user_id

      t.references "post", index: true
      t.references "user", index: true

      t.timestamps null: false
    end
  end
end
