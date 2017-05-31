class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    # { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
     { host: ENV['HOST'] || 'localhost:3000' }
  end

  # def default_link_options
  #   { { host: ENV['HOST'] || 'http://www.happynvestor.fr/' } }
  # end

   private

  # def skip_pundit?
  #   devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  # end
end

