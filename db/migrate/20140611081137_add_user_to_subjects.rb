class AddUserToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :user_id, :integer, null: false
  end
end
