class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :connect_pebble


  def after_sign_up_path_for(resource_or_scope)
    setup_notice_path
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def connect_pebble
    if params[:pebble_token]
      @token = params[:pebble_token]
    end

    if params[:user]
      @token = params[:user][:pebble_token]
    end

    if user_signed_in?
      current_user.pebble_token = @token
      current_user.save
      render 'pebble_success', layout: 'minimal'
    else
      render layout: 'minimal'
    end
  end

  def setup_notice
  end
end
