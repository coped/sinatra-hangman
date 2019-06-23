require 'sinatra'
require 'sinatra/reloader' if development?
require './public/hangman.rb'

set :game, Game.new

get '/' do
    settings.game = Game.new
    erb :index, layout: :main, :locals => {
        :hangman => settings.game.display_hangman,
        :word_progress => settings.game.word_progress,
    }
end

get '/play' do
    guess = params['guess'].strip.downcase
    settings.game.check_guess(guess)
    word_reveal = "The word was #{settings.game.secret_word}"
    erb :play, layout: :main, :locals => {
        :word_progress => settings.game.word_progress,
        :word_reveal => word_reveal,
        :over => settings.game.over,
        :header => settings.game.get_header,
        :hangman => settings.game.display_hangman,
        :lives_left => settings.game.lives_left,
        :incorrect_guesses => settings.game.incorrect_guesses,
        :secret_word => settings.game.secret_word,
    }
end
