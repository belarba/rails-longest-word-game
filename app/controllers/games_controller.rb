require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @score ||= session[:score]
    @word = params[:word]
    @letters = params[:letters].split(' ')
    @grid_ok = 0

    array_grid = @letters
    array_attempt = @word.upcase.split("")
    array_attempt.each do |char|
      if array_grid.include?(char)
        array_grid.delete_at(array_grid.find_index(char))
      else
        session[:score] = session[:score] - 1
        @grid_ok = 1
      end
    end

    if @grid_ok.zero?
      return_wagon = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
      answer = JSON.parse(return_wagon)
      if answer['found'] == false
        session[:score] = session[:score] - 1
        @grid_ok = 2
      end
    end

    session[:score] = session[:score] + @word.size if @grid_ok.zero?

    @score = session[:score]
    @letters = params[:letters]
  end
end
