class CreateMeetingPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :meeting_plans do |t|
      t.string :name

      t.timestamps
    end
  end
end
