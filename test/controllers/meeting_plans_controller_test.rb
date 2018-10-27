require 'test_helper'

class MeetingPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meeting_plan = meeting_plans(:one)
  end

  test "should get index" do
    get meeting_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_meeting_plan_url
    assert_response :success
  end

  test "should create meeting_plan" do
    assert_difference('MeetingPlan.count') do
      post meeting_plans_url, params: { meeting_plan: { name: @meeting_plan.name } }
    end

    assert_redirected_to meeting_plan_url(MeetingPlan.last)
  end

  test "should show meeting_plan" do
    get meeting_plan_url(@meeting_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_meeting_plan_url(@meeting_plan)
    assert_response :success
  end

  test "should update meeting_plan" do
    patch meeting_plan_url(@meeting_plan), params: { meeting_plan: { name: @meeting_plan.name } }
    assert_redirected_to meeting_plan_url(@meeting_plan)
  end

  test "should destroy meeting_plan" do
    assert_difference('MeetingPlan.count', -1) do
      delete meeting_plan_url(@meeting_plan)
    end

    assert_redirected_to meeting_plans_url
  end
end
