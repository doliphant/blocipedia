class UsersController < ApplicationController

  def upgrade
    @user = current_user
  end

# switches role between public and premium
  def toggle_role
    @user = current_user

    if @user.admin? == 'admin'
      flash[:error] = "User is an admin. No update."
    elsif @user.public?
      # @user.update_attribute(:role, 'premium')
      go_premium
      flash[:notice] = "User switched from public to premium."
    else
      # @user.update_attribute(:role, 'public')
      go_public
      flash[:notice] = "User switched from premium to public."
    end
    redirect_to users_upgrade_path
  end

  def go_premium
    @user = current_user
    @user.update_attribute(:role, 'premium')
  end

  def go_public
    @user = current_user
    @user.update_attribute(:role, 'public')
    flash[:notice] = "User switched from premium to public."
    redirect_to edit_user_registration_path
  end


end
