class AddCatToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :cat, :integer, null: false, default: 0
  end
end
