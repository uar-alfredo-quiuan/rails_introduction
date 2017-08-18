class DashboardController < ApplicationController
  def index
    puts current_user.role
    if current_user.role == "admin"
      redirect_to users_path
    else
      redirect_to edit_user_registration_path
    end
  end
end
