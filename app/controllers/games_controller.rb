class GamesController < ApplicationController
  def home

  end

  def new
    num = params[:num].to_i
    array = ('a'..'z').to_a
    @ran_sam = array.sample(num)
    @start = Time.now
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    start_time = params[:start].to_i
    finish = Time.now.to_i
    @bool = "The given attempt is " + check_english(@word)
    @bool += in_the_grid?(@grid, @word)
    @time = (finish - start_time) / 3600
    @score = points(@word, start_time, finish)
  end

  def check_english(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"

    uri = URI(url)
    response = Net::HTTP.get(uri)
    user = JSON.parse(response)

    if user["found"]
      "an English word, "
    else
      "not an english word, "
    end
  end

  def in_the_grid?(grid, attempt)
    arr = attempt.upcase.split('')
    if arr.uniq.all? { |x| grid.count(x) >= arr.count(x) }
      "it is in the grid!"
    else
      "it is not in the grid"
    end
  end

  def points(attempt, start_time, end_time)
    attempt.length / (end_time - start_time)
  end
end
