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
    
    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [6, 4, 2] # cannot be [2,4,6]
    ]

    def won?(board) 
        WIN_COMBINATIONS.find do |wc|
            win_index_1 = wc[0]
            win_index_2 = wc[1]
            win_index_3 = wc[2]
    
            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]
            
    
            position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
        end
    end
    
    
    def full?(board) 
        board.all? { |i| i == "X" || i == "O"} #if the board full with either X or O
    end
    
    def draw?(board)
        !won?(board) && full?(board)  #No winner and the board is full
    end
    
    def over?(board)
        draw?(board) || won?(board)
    end
    
    def winner(board)
        if wc = won?(board) #won method was define on line 73
            return board[wc[0]]
        end
    end
    
    def play(board)
        counter = 0 
        until counter == 9
            turn(board) # turn method was define in line 44
            counter += 1
        end
        puts won?(board) ? "Woohoo! #{winner(board)}" : "Sorry. Try again..."   
    end
    
    def current_player(board)
        turn_count(board) % 2 == 0? "X" : "O"
        # turn_count(board).even? ? "X" : "O"
    end
    
    def turn_count(board)
        board.count { |space| space == "X" || space == "O"}
    end
    
