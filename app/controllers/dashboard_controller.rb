class DashboardController < ApplicationController
  def index
    @q1 = Response.where(kind: 1).order(:datetime)
    @q2 = Response.where(kind: 2).order(:datetime)

    @answers1 = []
    @q1.each do |response|
      @answers1 << response.level
    end

    @dates1 = []
    @q1.each do |response |
        @dates1 << response.datetime.to_formatted_s(:db)
    end

    @answers2 = []
    @q2.each do |response|
      @answers2 << response.level
    end
  end
end