class UserController < ApplicationController
  def login
  end

  def profile
    @user = nil
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user if user_signed_in?
    end
    respond_to do |format|
      if @user
        format.html { render :profile }
      else
        format.html { render :login }
      end
    end

  end
end
