require "open-uri"

class GamesController < ApplicationController

  def new
    generate_grid()
  end

  def generate_grid
    # TODO: generate random grid of letters
    letter = ("A".."Z").to_a
    @letters = 10.times.map { letter.sample }
    @letters.join(" ")
  end

  def score
    @letters = params['letters'].split(" ")
    word = params[:word].upcase
    url = "https://dictionary.lewagon.com/#{word}"
    @dictionary = JSON.parse(URI.open(url).read)
    if @dictionary['found'] && valid_word?(word, @letters)
      @sucess = "<strong>Congratulations! </strong>#{word} is a valid english word".html_safe
    elsif @dictionary['found'] && !valid_word?(word, @letters)
      @cant_build_word = "<strong>Sorry but</strong>  #{word} can't be built out of #{@letters.join(" ")}".html_safe
    else
      @not_eng_word = "<strong>Sorry,</strong> #{word} is not a valid English word".html_safe
    end
  end

  def valid_word?(word_array, letters)
    word_array.chars.all? { |letter| word_array.chars.count(letter) <= letters.count(letter) }
  end

end


# Can the word be built?
  #   if !valid_word?(user_word_array, @letters)
  #     "Sorry but #{params['word']} can't be built out of #{@letters}"
  #   # Is it an actual english word?
  #   elsif fetch("url")
  #     "Congratulations! #{params['word']} is a valid english word "
  #   else
  #     "Sorry, #{params['word']} is not a valid English word"
  #   end
  # end
