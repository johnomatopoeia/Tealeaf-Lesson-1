# Calculator

# User inputs number#1
# User inputs an operator
# User inputs number#2

expression = ""

system 'clear'
puts "-------------------------------------------------------"
puts "| Simple Calculator *_*                               |"
puts "-------------------------------------------------------"
puts ""
begin  
  puts "The first number:"
  num1 = gets.chomp
end until num1 =~ /\d/
expression += num1

while true
  puts "Please enter the Arithmetic operator: [+] [-] [*] [/] [%] [**]"
  operator = gets.chomp
  if ['+','-','*','/','%','**'].include? operator
    break
  else  
    puts "Wrong! -_- "
  end
end
expression += " #{operator} "

begin  
  puts "The second number:"
  num2 = gets.chomp
end until num2 =~ /\d/
expression += num2

result = eval(expression)

puts "The expression => #{expression} = #{result}"
puts "-------------------------------------------------------"
puts ""