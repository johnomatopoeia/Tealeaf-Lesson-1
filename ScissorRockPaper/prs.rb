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

PRS = { paper:p, rock:r, scissor:s }

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
  if user_choice == "P" && computer_choice == "P"
    printf PRS[:paper]
    puts " vs "
    puts ""
    printf PRS[:paper]
    puts "Tie..."
  elsif user_choice == "P" && computer_choice == "R"
    printf PRS[:paper]
    puts " vs "
    puts ""
    printf PRS[:rock]
    puts "Ya, you win."
  elsif user_choice == "P" && computer_choice == "S"
    printf PRS[:paper]
    puts " vs "
    puts ""
    printf PRS[:scissor]
    puts "Sorry, you lose."

  elsif user_choice == "R" && computer_choice == "P"
    printf PRS[:rock]
    puts " vs "
    puts ""
    printf PRS[:paper]
    puts "Sorry, you lose."
  elsif user_choice == "R" && computer_choice == "R"
    printf PRS[:rock]
    puts " vs "
    puts ""
    printf PRS[:rock]
    puts "Tie..."
  elsif user_choice == "R" && computer_choice == "S"
    printf PRS[:rock]
    puts " vs "
    puts ""
    printf PRS[:scissor]
    puts "Ya, you win."
  elsif user_choice == "S" && computer_choice == "P"
    printf PRS[:scissor]
    puts " vs "
    puts ""
    printf PRS[:paper]
    puts "Ya, you win."
  elsif user_choice == "S" && computer_choice == "R"
    printf PRS[:scissor]
    puts " vs "
    puts ""
    printf PRS[:rock]
    puts "Sorry, you lose."
  elsif user_choice == "S" && computer_choice == "S"
    printf PRS[:scissor]
    puts " vs "
    puts ""
    printf PRS[:scissor]
    puts "Tie..."
  end

  puts ""
  puts "(E)xit or press any key to play again."
  exit = gets.chomp.upcase
  system 'clear'
  break if exit =~ /[E]/
end
 
puts "Bye Bye."