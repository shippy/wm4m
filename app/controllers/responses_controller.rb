class ResponsesController < ApplicationController
  protect_from_forgery with: :null_session

  def add
    # debug
    puts params

    # TODO: Authentication logic (is the pebble ID registered here?)

    response = Response.new(response_params)
    response.datetime = DateTime.now

    if response.save
      render status: 200, text: "Success (response saved)"
    else
      render status: 500, text: "Failure to save response"
    end
  end

  private

    def response_params
      params.require(:response).permit(:kind, :level, :user)
    end
end
