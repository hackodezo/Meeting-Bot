class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def process_audio
    file = params[:file]
    audio_data = Base64.decode64(file['data:audio/ogg;base64,'.length .. -1])
    save_path = Rails.root.join('public/audio')
    file_path = "#{save_path}_audio_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.ogg"
    unless File.exists?(save_path)
      Dir::mkdir(Rails.root.join("public/audio"))
    end
    file = File.open(file_path, 'wb') do |f| f.write audio_data end
    flac_audio = convert_mp3_to_flac(file_path)
    message = AudioConverter.new(flac_audio).speech_streaming_recognize
    respond_to do |format|
      format.json {render json: {message: message} }
    end
  end

  def convert_mp3_to_flac(file_path)
    f_path = file_path.sub(".ogg", ".flac")
    system("ffmpeg -i #{file_path} -ac 1 #{f_path}")
    f_path
  end 

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :venue, :agenda, :meeting_date, :start_time, :end_time, :meeting_plan_id)
    end
end
