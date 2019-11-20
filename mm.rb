# develop classes here

class Mastermind
    attr_accessor :turns, :code, :guesses, :difficulty
    attr_reader :win

    public
    def display_board()
        puts "MASTERMIND"
        2.times {puts ""}
        i = 0
        for x in @guesses do
            linefeed = "Round #{i+1}: "
            (11-linefeed.length).times do
                linefeed += " "
            end
            for p in x do
                linefeed += "#{p}  "
            end
            puts linefeed
            puts ""
            i += 1
        end

        @turns += 1
    end
    
    def validate_guess(guess)
        if guess.to_s.length == @code.length
            return true
        else
            return false
        end
    end

    def check_guess(guess)
        guess_feedback = []
        i = 0
        guess.to_s.length.times do 
            guessed_digit = guess.to_s[i]
            code_digit = @code[i]
            @win = true

            # tests the digits in the guess
            if guessed_digit.to_i == code_digit
                @guesses[@turns-1][i] = " #{guessed_digit} "
            elsif @code.include?(guessed_digit.to_i)
                @guesses[@turns-1][i] = "(#{guessed_digit})"
                @win = false
            else
                @guesses[@turns-1][i] = "-#{guessed_digit}-"
                @win = false
            end

            i += 1
        end
    end
    
    def initialize
        @turns = 0
        system "clear"
        puts "Welcome to MASTERMIND!"
        puts ""
        @win = false
        @difficulty = set_difficulty()
        @code = generate_code(@difficulty)
        @guesses = generate_guesses_array(@code.length)
    end
    
    def new_game
    end
    
    def quit
    end

    def display_instructions
        system "clear"
        puts "MASTERMIND"
        puts ""
        puts "-3-  <--  Number and placement are both wrong"
        puts "(3)  <--  Number is in the code, but placement is wrong"
        puts " 3   <--  Number and placement are both correct"
        puts ""
        puts "Press ENTER to Continue"
        gets.chomp
        system "clear"
    end
    
    private

    def set_difficulty
        puts "Choose a difficulty level for this game (1 - 3)"
        puts "1) Easy - 3 digit codes"
        puts "2) Medium - 4 digit codes"
        puts "3) Hard - 5 digit codes"
        
        diff = gets.chomp.to_i
        while diff < 1 || diff > 3
            diff = gets.chomp.to_i
        end
        return diff
    end
        
    def generate_code(diff)
        len = 2 + diff
        password = []
        len.times do
            password << rand(9)
        end
        return password
    end

    def generate_guesses_array(len)
        guesses = []
        10.times do
            guesses << len.times.collect {"___"}
        end
        return guesses
    end
end

# Game Flow:

mm = Mastermind.new
system "clear"
mm.display_instructions()
loop do
    break if mm.win == true
    mm.display_board()
    puts ""
    puts "Guess the Code:"
    guess = gets.chomp
    puts ""

    while mm.validate_guess(guess) == false
        puts "You must guess a #{2 + mm.difficulty} digit number!"
        guess = gets.chomp
    end
    
    mm.check_guess(guess)
    system "clear"
end
mm.display_board()
puts "YOU WIN!"