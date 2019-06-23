require 'sinatra'
require 'sinatra/reloader' if development?
require './public/hangman.rb'

game = Game.new

get '/' do
    game = Game.new
    erb :index, layout: :main, :locals => {
        :hangman => game.display_hangman,
        :word_progress => game.word_progress,
    }
end

get '/play' do
    guess = params['guess'].strip.downcase
    game.check_guess(guess)
    word_reveal = "The word was #{game.secret_word}"
    erb :play, layout: :main, :locals => {
        :word_progress => game.word_progress,
        :word_reveal => word_reveal,
        :over => game.over,
        :header => game.get_header,
        :hangman => game.display_hangman,
        :lives_left => game.lives_left,
        :incorrect_guesses => game.incorrect_guesses,
        :secret_word => game.secret_word,
    }
end
