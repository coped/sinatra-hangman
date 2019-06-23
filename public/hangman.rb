class Game
    attr_reader :secret_word, :lives_left, :over, :incorrect_guesses

    def initialize
        @secret_word = get_word
        @lives_left = 6
        @over = false
        @win = false
        @correct_guesses = []
        @incorrect_guesses = []
    end

    def check_guess(player_guess)
        secret_letters = @secret_word.downcase.split("")
        if secret_letters.include?(player_guess)
            @correct_guesses << player_guess
        else
            @incorrect_guesses << player_guess
            @lives_left -= 1
        end
                
        @over = true if @lives_left == 0
    end

    def get_header
        !@over ? 'Take another crack at it!' :
        @win ? 'You win!' : 'Too bad!'
    end

    def display_hangman
        case @lives_left
        when 6 then return 'images/scaffold-0.png'
        when 5 then return 'images/scaffold-1.png'
        when 4 then return 'images/scaffold-2.png'
        when 3 then return 'images/scaffold-3.png'
        when 2 then return 'images/scaffold-4.png'
        when 1 then return 'images/scaffold-5.png'
        when 0 then return 'images/scaffold-6.png'
        end
    end

    def word_progress
        word_progress = @secret_word.split("").map do |letter|
            letter = "_" unless @correct_guesses.include?(letter.downcase)
            letter
        end
        if word_progress.join == @secret_word
            @win = true
            @over = true
        end
        word_progress.join("  ")
    end
    
    def get_word
        word = ''
        until word.length >= 5 && word.length <= 12
            word = File.readlines('./public/5desk.txt')[rand(61406)].strip
        end
        word
    end
end
