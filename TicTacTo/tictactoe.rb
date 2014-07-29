require 'pry'

def initial_board
  #Array.new(9){|i| "%1s" % "x"}
  Array.new(9){|i| "%1s" % ""}
end

def draw_board (square)
  system "clear"
  puts "#{square[0]}|#{square[1]}|#{square[2]}"
  puts "-+-+-"
  puts "#{square[3]}|#{square[4]}|#{square[5]}"
  puts "-+-+-"
  puts "#{square[6]}|#{square[7]}|#{square[8]}"
 
end

def available_square(square_board)
  str_available_square=""
  square_board.each_with_index do |v,i| 
    str_available_square +="#{i+1}," if v == nil || v == " "
  end
  str_available_square.split(",")
end

def user_pick_a_square(square_board)
  a=available_square(square_board)
  puts "Please pick a square form #{a}."
  user_pick_square=gets.chomp

  # Question again if user input the wrong square index number.
  if ! a.include? "#{user_pick_square}"
    user_pick_a_square(square_board)
  else
    square_board[user_pick_square.to_i-1]="X"
  end
end

def computr_pick_a_square(square_board)
  a=available_square(square_board)
  puts "Computer pick a square from #{a}"
  rand_index=rand(a.size-1)
  square_board[ a[rand_index].to_i-1 ] = "O"
end

def available_square_empty? (square_board)
  (available_square(square_board).size <= 0) ?  true : false
end

def check_the_winner(square_board)
  winner=""
  winning_lines =[[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [3,5,7], [1,5,9]]
  
  winning_lines.each do |v|
    x_count = 0
    o_count = 0
      
    v.each do |i|
      x_count+=1 if square_board[i-1] == "X"
      o_count+=1 if square_board[i-1] == "O"
    end

    winner="The winner is 'X' player." if x_count ==3 
    winner="The winner is 'O' player." if o_count ==3 
  end

  winner
end

#----------------------------->>

winner="" 
square_board=initial_board
draw_board(square_board) 

begin
  user_pick_a_square(square_board) 
  
  winner=check_the_winner(square_board)
  is_empty = available_square_empty? (square_board)
  
  computr_pick_a_square(square_board) if !is_empty && winner.empty? 
  
  winner=check_the_winner(square_board)
  is_empty = available_square_empty? (square_board)

  draw_board(square_board)  
end until is_empty || !winner.empty? 

if winner.empty?
  puts "It's a tie."
else
  puts "Result: #{winner}" 
end

#----------------------------->>
