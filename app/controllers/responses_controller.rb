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

    if response.save
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
