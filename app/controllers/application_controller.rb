class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    if params[:user][:pebble_token]
      if URI.parse(request.referer).path == connect_pebble_sign_in_path(params[:user][:pebble_token])
        URI.parse(request.referer).path
      end
    end
  end

  def after_sign_up_path_for(resource_or_scope)
    setup_notice_path
  end
end
