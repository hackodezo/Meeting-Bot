class EmployeesController < ApplicationController

  def index
      @users = User.all
  end

end
