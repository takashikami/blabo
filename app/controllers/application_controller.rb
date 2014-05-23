class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_variant

  private

  def set_variant
    p request.user_agent
    request.variant = :sp if request.user_agent =~ /Android|iPad|iPhone/
  end
end
