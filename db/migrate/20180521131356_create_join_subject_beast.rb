class CreateJoinSubjectBeast < ActiveRecord::Migration[5.1]
  def change
    create_table :join_subject_beasts do |t|
      t.string :beast
      t.string :subject
    end
  end
end
