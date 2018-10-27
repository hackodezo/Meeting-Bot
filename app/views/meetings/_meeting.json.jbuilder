json.extract! meeting, :id, :name, :venue, :agenda, :meeting_date, :meeting_time, :duration, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
