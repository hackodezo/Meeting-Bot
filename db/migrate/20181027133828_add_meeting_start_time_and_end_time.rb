class AddMeetingStartTimeAndEndTime < ActiveRecord::Migration[5.1]
  def change
    remove_column :meetings, :meeting_time, :time
    remove_column :meetings, :duration, :time
    add_column :meetings, :start_time, :time
    add_column :meetings, :end_time, :time
  end
end
