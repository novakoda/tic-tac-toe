class Game
    def start
        puts "What is Player 1's name?"
        p1_name = gets.chomp
        @player_1 = Player.new(p1_name, "X")
        puts "What is Player 2's name?"
        p2_name = gets.chomp
        @player_2 = Player.new(p2_name, "O")

        @board = Board.new
        @board.show 
    end

    def turn(player)
        puts "#{player.name}, Enter the slot you want to mark"
        pick = gets.chomp
        slot = pick.to_i-1

        if @board.field[slot] == "X" || @board.field[slot] == "O" || pick.length != 1 || !pick[/[1-9]/]
            puts "Invalid entry"
            self.turn(player)
        else
            @board.field[slot] = player.mark
            @board.show
        end
    end

    def finish
        case @board.winner
        when "X"
            puts "#{@player_1.name} wins!"
        when "O"
            puts "#{@player_2.name} wins!" 
        else
            puts "It was a tie!" 
        end
        puts "Do you want to play again?"
        puts "Y/N"
        answer = gets.chomp.downcase
        accepted_answers = ["y", "yes"]
        declined_answers = ["n", "no"]
        until accepted_answers.any? { |item| answer == item } || declined_answers.any? { |item| answer == item }
            puts "Enter yes or no."
        end
        Game.new.play if accepted_answers.any? { |ans| ans == answer }
    end

    def play
        self.start
        until @board.full? || @board.winner
            self.turn(@player_1)
            break if @board.full? || @board.winner
            self.turn(@player_2)
        end
        self.finish
    end
end