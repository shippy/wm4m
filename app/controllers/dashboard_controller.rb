class DashboardController < ApplicationController
  def index
    @q1 = Response.where(kind: "1").order(:datetime)
    @q2 = Response.where(kind: "2").order(:datetime)

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

    @yes = 0.0
    @no = 0.0
    @q2.each do |response|
      if response.level == 3
        @yes = @yes + 1.0
      elsif response.level == 1
        @no = @no + 1.0
      end
    end
    @yes = @yes/ (@yes + @no)
    @no = 1 - @yes
  end
end
