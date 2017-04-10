class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :reload_rails_admin, if: :rails_admin_path?
  before_action :set_paper_trail_whodunnit

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def user_for_paper_trail
    puts "Am I Admin? #{current_user.admin?}" if current_user
    !current_user.nil? && current_user.admin? ? current_user.try(:id) : 1
  end

  # def reload_rails_admin
  #   models = %W(User UserProfile)
  #   models.each do |m|
  #     RailsAdmin::Config.reset_model(m)
  #   end
  #   RailsAdmin::Config::Actions.reset
  #
  #   load("#{Rails.root}/config/initializers/rails_admin.rb")
  # end
  #
  # def rails_admin_path?
  #   controller_path =~ /rails_admin/ && Rails.env.development?
  # end

end
