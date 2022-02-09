def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    # input = Integer(user_input) - 1 
    user_input.to_i - 1
    end
    
    def move(board, index, player = "X")
        board[index] = player
    end
    
    def position_taken?(board, index)
        !board[index]&.strip&.empty?
    end
    
    #dif methods for valid_move?
    
    # def valid_move?(board, index)
    #     index >= 0 && index < 9 && board[index].strip.empty?
    # end
    
    def valid_move?(board, index)
        (0..8) === index && !position_taken?(board, index)
    end
    
    # def valid_move?(board, index)
    #     index >= 0 && index < 9 && position_taken?(board, index)
    # end
    
    # def valid_move?(board, index)
    #     index.between?(0, 8) && !position_taken?(board, index)
    # end
    
    def turn(board)
        puts "Please enter 1-9:"
        input = gets.strip
        index_position = input_to_index(input)
        if valid_move?(board, index_position)
            move(board, index_position)
            display_board(board)
        else
            puts "Invalid move, try again!"
            puts "Position is taken or number is not between 1-9"
            turn(board)
        end
    end
    
    # turn([" ", " ", " ", " ", " ", " ", " ", " ", " "]) #to run the test on the turn method
    
    
    #find, if and else 
    def game_status
    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6] # cannot be [2,4,6]
    ]

    def won?(board) 
        WIN_COMBINATIONS.each do |wc| #wc is short for winning combination
            win_index_1 = wc[0]
            win_index_2 = wc[1]
            win_index_3 = wc[2]
    
            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]
            
            if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
                return wc
            end # comparing the position to each other and return the winning combo 
        end
        return false
    end
    
    def full?(board) 
        board.all? { |i| i == "X" || i == "O"} #if the board full with either X or O
    end
    
    def draw?(board)
        if !won?(board) && full?(board) #No winner and the board is full
            return true
        elsif !won?(board) && !full?(board) #
            return false
        else won?(board)
            return false
        end
    end
    
    def over?(board)
        if draw?(board) || won?(board) || full?(board)
            return true
        end
    end
    
    def winner(board)
        if won?(board) #won method was define on line 73
            return board[won?(board)[0]]
        end
    end
    
    def play(board)
        counter = 0 
        until counter == 9
            turn(board) # turn method was define in line 44
            counter += 1
        end
    end
    
    def current_player(board)
        turn_count(board) % 2 == 0? "X" : "O"
    end
    
    def turn_count(board)
        counter = 0
        board.each {|space|
        if space == "X" || space == "O"
        counter += 1
        end
        }
        counter
    end
    end
