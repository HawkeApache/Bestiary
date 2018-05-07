class CreateBeasts < ActiveRecord::Migration[5.1]
  def change
    create_table :beasts do |t|
      t.string :firstname
      t.string :lastname
      t.string :pseudo
      t.string :degree
      t.float :rating
      t.text :bio

      t.timestamps
    end
  end
end
