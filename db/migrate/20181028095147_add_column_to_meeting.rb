class AddColumnToMeeting < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :audio_data, :text
    add_column :meetings, :transcribed_text, :text
  end
end
