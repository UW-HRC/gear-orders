class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verify_open
    if ENV['CLOSED']
      redirect_to root_path, alert: 'Unfortunately, gear orders are closed.'
    end
  end
end
