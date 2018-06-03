class AddSubjectToComment < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :subject, foreign_key: true
  end
end
