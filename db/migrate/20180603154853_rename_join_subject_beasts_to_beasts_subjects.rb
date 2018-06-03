class RenameJoinSubjectBeastsToBeastsSubjects < ActiveRecord::Migration[5.2]
  def change
    rename_table :join_subject_beasts, :beasts_subjects
  end
end
