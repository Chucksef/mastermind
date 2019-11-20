# develop classes here

class Mastermind
    attr_accessor :turns, :code, :guesses

    public
    def display_board()
        i = 1
        for x in @guesses do
            linefeed = "Round #{i}: "
            (11-linefeed.length).times do
                linefeed += " "
            end
            for p in x do
                linefeed += "___  "
            end
            puts linefeed
            puts ""
            i += 1
        end

        @turns += 1
    end
    
    def validate_guess(guess)
    end

    def check_guess(guess)
    end
    
    def initialize
        @turns = 0
        system "clear"
        puts "Welcome to MASTERMIND!"
        puts ""
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
        puts "(3)  <--  Number is correct, placement is wrong"
        puts " 3   <--  Number and placement are both correct"
        puts ""
        puts "Press any Key to Continue"
        STDIN.getch
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
            guesses << len.times.collect {"_"}
        end
        return guesses
    end

end

# Game Flow:

mm = Mastermind.new
system "clear"
loop do
    mm.display_board()
    puts ""
    puts "Guess the Code:"
    guess = gets.chomp
    puts ""
    #validate guess
    mm.check_guess(guess)
end

# Request Input