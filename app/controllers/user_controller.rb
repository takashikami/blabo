class UserController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def login
  end

  def profile
  end
end
