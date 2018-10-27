class MeetingPlansController < ApplicationController
  before_action :set_meeting_plan, only: [:show, :edit, :update, :destroy]

  # GET /meeting_plans
  # GET /meeting_plans.json
  def index
    @meeting_plans = MeetingPlan.all
  end

  # GET /meeting_plans/1
  # GET /meeting_plans/1.json
  def show
  end

  # GET /meeting_plans/new
  def new
    @meeting_plan = MeetingPlan.new
  end

  # GET /meeting_plans/1/edit
  def edit
  end

  # POST /meeting_plans
  # POST /meeting_plans.json
  def create
    @meeting_plan = MeetingPlan.new(meeting_plan_params)

    respond_to do |format|
      if @meeting_plan.save
        format.html { redirect_to @meeting_plan, notice: 'Meeting plan was successfully created.' }
        format.json { render :show, status: :created, location: @meeting_plan }
      else
        format.html { render :new }
        format.json { render json: @meeting_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meeting_plans/1
  # PATCH/PUT /meeting_plans/1.json
  def update
    respond_to do |format|
      if @meeting_plan.update(meeting_plan_params)
        format.html { redirect_to @meeting_plan, notice: 'Meeting plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting_plan }
      else
        format.html { render :edit }
        format.json { render json: @meeting_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_plans/1
  # DELETE /meeting_plans/1.json
  def destroy
    @meeting_plan.destroy
    respond_to do |format|
      format.html { redirect_to meeting_plans_url, notice: 'Meeting plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_plan
      @meeting_plan = MeetingPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_plan_params
      params.require(:meeting_plan).permit(:name)
    end
end
