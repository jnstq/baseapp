# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include RoleRequirement
    
  helper :all # include all helpers, all the time
  
  # Return the value for a given setting
  def s(identifier)
    Setting.get(identifier)
  end
  helper_method :s

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9fe6825f97cc334d88925fde5c4808a8'
  
  before_filter :set_locale
  
  # copy & paste from i18n_demo_app
  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]

    # set locale based on session or default 
    I18n.locale = session[:locale] || I18n.default_locale

    # load locale from settings
    @locale_files = []
    ['yml', 'rb'].each do |type|
      locale_file = "#{LOCALES_DIRECTORY}#{I18n.locale}.#{type}"
      if File.exists?(locale_file)
        @locale_files << locale_file
        I18n.backend.load_translations locale_file
      end
    end
  end
  
end
