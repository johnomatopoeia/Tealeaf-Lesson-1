# Paper Rock Scissor

r = "Rock:\n"
r += "      _______\n"
r += "  ---'   ____)\n"
r += "        (_____)\n"
r += "        (_____)\n"
r += "        (____)\n"
r += "  ---.__(___)\n"
r +="\n"

p = "Paper:\n"
p += "      _______\n"
p += "  ---'   ____)____\n"
p += "            ______)\n"
p += "            _______)\n"
p += "           _______)\n"
p += "  ---.__________)\n"
p +="\n"

s = "Scissors:\n"
s += "      _______\n"
s += "  ---'   ____)______\n"
s += "            ________)\n"
s += "         ____________)\n"
s += "        (____)\n"
s += "  ---.__(__)  \n"
s +="\n"


PRS = { "P" => p, "R" => r, "S" => s }

system 'clear'
puts "-------------------------------------------------------"
puts "| Paper Rock Scissor  *_*                             |"
puts "|                                                     |"
puts "| ASCII art ref: http://ascii.co.uk/art/finge         |"
puts "-------------------------------------------------------"

puts ""

while true  
  begin  
    printf " (P)aper (R)ock (S)cissor ?"    
    user_choice = gets.chomp.upcase
  end until user_choice =~ /[PRS]/

  computer_choice=['P','R','S'].shuffle.first
  
  puts ""
  printf PRS[user_choice]
  puts " vs "
  puts ""
  printf PRS[computer_choice]

  if user_choice == "P" && computer_choice == "P" || user_choice == "R" && computer_choice == "R" || user_choice == "S" && computer_choice == "S"      
     puts "Tie..."
  elsif user_choice == "P" && computer_choice == "R" ||user_choice == "R" && computer_choice == "S" || user_choice == "S" && computer_choice == "P"
    puts "Ya, you win."
  elsif user_choice == "P" && computer_choice == "S" || user_choice == "R" && computer_choice == "P"  || user_choice == "S" && computer_choice == "R"       
    puts "Sorry, you lose."
  end

  puts ""
  puts "(E)xit or press any key to play again."
  exit = gets.chomp.upcase
  system 'clear'
  break if exit =~ /[E]/
end
 
puts "Bye Bye."