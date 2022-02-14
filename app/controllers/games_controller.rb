require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
  end

  def letter_in_grid
  @answer.chars.all? { |letter| @answer.count(letter) <= @grid.count(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    if !letter_in_grid
      @result = "déso, #{@answer.upcase} ne marche pas à partir de #{@grid}."
    elsif !english_word
      @result = "déso, #{@answer.upcase} n'est pas un mot valide."
    elsif letter_in_grid && !english_word
      @result = "déso, #{@answer.upcase} n'est pas un mot valide."
    else letter_in_grid && !english_word
      @result = "Bravo  ! #{@answer.upcase} est valide."
    end
  end

end
