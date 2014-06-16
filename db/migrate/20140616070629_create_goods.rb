class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.integer :score, null: false, default: 1
      t.integer :comment_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
