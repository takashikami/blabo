class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :pic
      t.text :quote

      t.timestamps
    end
  end
end
