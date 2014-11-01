class ResponsesController < ApplicationController
  protect_from_forgery with: :null_session

  def add
    puts params
    response = Response.new(response_params)
    response.save

    # TODO: Authentication logic (is the pebble ID registered here?)
    render status: 200, text: "Success (response saved)"
  end

  private

    def response_params
      params.require(:response).permit(:kind, :level, :datetime)
    end
end
