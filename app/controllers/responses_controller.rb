require 'contact_mailer'
class ResponsesController < ApplicationController
  protect_from_forgery with: :null_session

  def add
    # TODO: Authentication logic (is the pebble ID registered here?)

    response = Response.new(response_params)
    # response.user = User.find(response_params[:response][:user_id])
    response.datetime = DateTime.now
    # debug
    puts params
    puts response_params
    puts response

    stress_mean = Response.where(kind: "1", user: current_user).pluck(:level).last(5).sum / 5.0
    happiness_mean = Response.where(kind: "2",user: current_user).pluck(:level).last(5).sum / 5.0
    threshold = 1.5

    if response.save
      if stress_mean > threshold && happiness_mean < threshold
        puts "Sending an e-mail triggered!"
        ContactMailer.depressing_email(current_user, current_user.contacts.sample).deliver
      else
        puts "Sending an e-mail not triggered! Stress mean #{stress_mean}, happiness #{happiness_mean}"
      end
      render status: 200, text: "Success (response saved)"
    else
      render status: 500, text: "Failure to save response"
    end
  end

  private
    def response_params
      params.require(:response).permit(:kind, :level, :user_id)
    end
end
