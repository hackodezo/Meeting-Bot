class CreateMeetingNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :meeting_notes do |t|
      t.integer :meeting_id
      t.text :dec
      t.string :file_path

      t.timestamps
    end
  end
end
