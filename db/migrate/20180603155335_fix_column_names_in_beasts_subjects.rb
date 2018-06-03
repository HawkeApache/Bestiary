class FixColumnNamesInBeastsSubjects < ActiveRecord::Migration[5.2]
  def change
    rename_column :beasts_subjects, :beast, :beast_id
    rename_column :beasts_subjects, :subject, :subject_id
  end
end
