class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.string :name
      t.string :venue
      t.string :agenda
      t.date :meeting_date
      t.time :meeting_time
      t.time :duration
      t.integer :meeting_plan_id

      t.timestamps
    end
  end
end
