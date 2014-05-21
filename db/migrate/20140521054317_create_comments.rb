class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :subject_id, null: false
      t.text :comment

      t.timestamps
    end
  end
end
