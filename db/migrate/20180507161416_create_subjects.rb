class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :ects
      t.string :description
      t.float :rating

      t.timestamps
    end
  end
end
