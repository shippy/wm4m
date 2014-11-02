class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    setup_notice_path
  end
end