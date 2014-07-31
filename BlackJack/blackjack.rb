#require 'pry'

class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def brown;          "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def bg_black;       "\033[40m#{self}\033[0m" end
  def bg_red;         "\033[41m#{self}\033[0m" end
  def bg_green;       "\033[42m#{self}\033[0m" end
  def bg_brown;       "\033[43m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
  def bg_magenta;     "\033[45m#{self}\033[0m" end
  def bg_cyan;        "\033[46m#{self}\033[0m" end
  def bg_gray;        "\033[47m#{self}\033[0m" end
  def bold;           "\033[1m#{self}\033[22m" end
  def reverse_color;  "\033[7m#{self}\033[27m" end
end

BlackJack = "BlackJack"
TwentyOne = "Twenty-One"
Bursted = "Bursted!"
Stay = "Stay"
Hit = "Hit"
Win = "win"
Lose = "lose"
Draw = "draw"
DECK = 2 #  the number of 52-cards deck
remainder_cards = [] 
people={delear:{name: "Big_Boss_Daniel_Tsneg", hands:[]}, players:[]} 

def welcome?(people)
  system 'clear'
  puts "Wellcome to Daniel's BlackJack Poker Party ^_^Y"
  p="P".blue.reverse_color
  e="E".blue.reverse_color
  printf "Start to (#{p})lay or (#{e})xit ? "
  user_i=gets.chomp.strip.upcase
  if user_i=="P"
    puts ""
    puts "[Add Players]"
    add_players(people)
    true
  else 
    system 'clear'
    puts "Bye, Bye..."
    false
  end
end

def add_players(people)
  begin 
    printf "Tell me your name: "
    player_name = gets.chomp.split.join("_").strip
    puts "You don't tell me your name. Try again, thanks." if player_name.empty?
    puts "The name, '#{player_name}', has alread been used. Try another one, thanks." if people[:players].include?(player_name)
    (!player_name.empty? && !people[:players].include?(player_name)) ? valid_player_name = true : valid_player_name = false 
  end until valid_player_name 
  people[:players].push({name:player_name, hands:[]})
  printf "Hi, '#{player_name.blue}', nice to meet you. \n"
  printf "Another people want to play? (Y/N) "
  add_players(people) if gets.chomp.strip.upcase == "Y"
end

def add_cards? (remainder_cards)
  if remainder_cards.size <  DECK * 52 / 2
      a=[]
      f=['♠','♥','♦','♣']
      n=['A','2','3','4','5','6','7','8','9','10','J','Q','K']
      (1..DECK).each do |d|
        f.each do |x|
           n.each do |y|
              a.push "#{y}#{x}"
           end 
        end
      end
      a.shuffle!
      remainder_cards.push(*a)
      true
      #p remainder_cards  
      #p a.shuffle
      #A♥ heart-h
      #J♠ spafes-s 
      #Q♦ diamond-d
      #K♣ clubs-c
  else 
    false
  end
end

def hit_card (name,cards,remainder_cards)
  add_cards? remainder_cards
  cards.push remainder_cards.shift
end

def count_cards_value (hand)    
  cards = hand[:cards]
  c=[0]
  cards.each_with_index do |v,i|
    number = v.gsub /[♥♠♦♣]/,""
    suit = v.gsub /[\d\w]/,""
    t=[]
    c.each_with_index do |x,y|      
      if number == "A"
        c[y] = x.to_i + 1
        t.push x.to_i + 11
      elsif  number == "J" || number == "Q" || number == "K" 
        c[y] = x.to_i+ 10
      else
        c[y] = x.to_i + number.to_i
      end
    end
    c = c + t
  end
  max_count_cards = (c.dup.delete_if { |v| v > 21 }.sort.reverse[0])
  if max_count_cards == nil
    hand[:note] =  Bursted
    hand[:count_cards] = c.sort[0].to_i
  elsif max_count_cards == 21
    hand[:note] = (cards.size == 2 ) ? BlackJack : TwentyOne
    hand[:count_cards] = max_count_cards.to_i
  elsif 
    hand[:count_cards] = max_count_cards.to_i
  end
end

def start_poker_party(people,remainder_cards)
  delear = people[:delear]
  delear_name = delear[:name]
  delear_hand = {cards:[], count_cards:"", note:"", vs_result:{}} 
  delear[:hands].push delear_hand
  delear_cards = delear_hand[:cards]
  hit_card delear_name,delear_cards,remainder_cards
  hit_card delear_name,delear_cards,remainder_cards
  count_cards_value delear_hand
    
  people[:players].each do |player|
    player_name = player[:name]
    player_hand = {cards:[], count_cards:"", note:"", vs_result:""} 
    player[:hands].push player_hand
    player_cards = player_hand[:cards]
    hit_card player_name,player_cards,remainder_cards
    hit_card player_name,player_cards,remainder_cards
    count_cards_value player_hand
  end
end

def win_or_lose (people)
  delear = people[:delear]
  delear_name = delear[:name]
  delear_hand = delear[:hands].last
  delear_cards = delear_hand[:cards]
  count_cards_value delear_hand
  delear_note = delear_hand[:note]
  delear_count_cards = delear_hand[:count_cards].to_i

  # player vs delear
  people[:players].each do |player|
    player_name = player[:name]
    player_hand = player[:hands].last
    player_cards = player_hand[:cards]
    count_cards_value player_hand
    player_note = player_hand[:note]
    player_count_cards = player_hand[:count_cards].to_i
    if delear_note== BlackJack 
      if player_note == BlackJack
        player_hand[:vs_result] = Draw
        delear_hand[:vs_result][player_name] = Draw
      else
        player_hand[:vs_result] = Lose
        delear_hand[:vs_result][player_name] = Win
      end 
    elsif delear_note == TwentyOne
      if player_note == BlackJack
        player_hand[:vs_result] = Win
        delear_hand[:vs_result][player_name] = Lose
      elsif player_note == TwentyOne
        player_hand[:vs_result] = Draw
        delear_hand[:vs_result][player_name] = Draw
      else
        player_hand[:vs_result] = Lose
        delear_hand[:vs_result][player_name] = Win
      end
    elsif delear_note == Bursted
      if player_note == Bursted
        player_hand[:vs_result] = Draw
        delear_hand[:vs_result][player_name] = Draw
      else
        player_hand[:vs_result] = Win
        delear_hand[:vs_result][player_name] = Lose
      end
    elsif player_note == Bursted
        player_hand[:vs_result] = Lose
        delear_hand[:vs_result][player_name] = Win
    else
      if delear_count_cards > player_count_cards
        player_hand[:vs_result] = Lose
        delear_hand[:vs_result][player_name] = Win
      elsif delear_count_cards == player_count_cards
        player_hand[:vs_result] = Draw
        delear_hand[:vs_result][player_name] = Draw
      else
        player_hand[:vs_result] = Win
        delear_hand[:vs_result][player_name] = Lose
      end
    end
  end  
end


def stay_or_hit (people,remainder_cards)
  puts " "+"-> Player <-".reverse_color
  puts ""
  people[:players].each do |player|
    player_name = player[:name]
    player_hand = player[:hands].last
    player_cards = player_hand[:cards]
    player_count_cards = player_hand[:count_cards]
    puts "@#{player_name}".brown+": cards:#{player_cards}, count_cards:#{player_count_cards}"
    
    begin 
      player_note = player_hand[:note]
      if player_note == BlackJack
        puts "@#{player_name}".brown+": cards:#{player_cards}, count_cards:#{player_count_cards}, note:#{BlackJack} "
        stay_or_hit = "S"
      elsif player_note == TwentyOne
        puts "@#{player_name}".brown+": cards:#{player_cards}, count_cards:#{player_count_cards}, note:#{TwentyOne} "
        stay_or_hit = "S"
      elsif player_note == Bursted
        puts "@#{player_name}".brown+": cards:#{player_cards}, count_cards:#{player_count_cards}, note:#{Bursted} "
        stay_or_hit = "S"  
      else
        printf "@#{player_name}".brown+": (#{'H'.red})it or (#{'S'.red})tay ? "
        stay_or_hit=gets.chomp.upcase
        
        #---
        #if stay_or_hit =~ /[SH]/
        #---
        #+++
        if ['S','H'].include?(stay_or_hit) 
        #+++  
          if stay_or_hit == 'H'
            hit_card player_name,player_cards,remainder_cards
            count_cards_value player_hand # to_i will bypass 'Bursted / BlackJack' string ex: '21-BlackJack'.to_i == 21"
            player_count_cards = player_hand[:count_cards]
            player_note = player_hand[:note]
            puts "@#{player_name}".brown+": cards:#{player_cards}, count_cards:#{player_count_cards}}"              
          else stay_or_hit == 'S'
            player_hand[:note] == Stay
          end 
        else
          puts "Wrong input, S/H, please."
        end      
      end
      puts "" if stay_or_hit == 'S'
    end until stay_or_hit =~ /[S]/     
  end

  puts " "+"-> Delear <-".reverse_color
  puts ""
  delear = people[:delear]
  delear_name = delear[:name]
  delear_hand = delear[:hands].last
  delear_cards = delear_hand[:cards]
  delear_count_cards = delear_hand[:count_cards]
  puts "@#{delear_name}".brown+": cards:#{delear_cards}, count_cards:#{delear_count_cards}"
  begin     
    delear_note = delear_hand[:note]
    if delear_note == BlackJack
      puts "@#{delear_name}".brown+": cards:[#{delear_cards}, count_cards:#{delear_count_cards}, note:#{BlackJack} ]"
      stay_or_hit = "S"
    elsif delear_note == TwentyOne
      puts "@#{delear_name}".brown+": cards:[#{delear_cards}, count_cards:#{delear_count_cards}, note:#{TwentyOne} ]"
      stay_or_hit = "S"
    elsif delear_note == Bursted
      puts "@#{delear_name}".brown+": cards:[#{delear_cards}, count_cards:#{delear_count_cards}, note:#{Bursted} ]"
      stay_or_hit = "S"
    elsif delear_count_cards >= 17 # 'delear' Stay (count_cards is at least 17) or Hit 
      delear_hand[:note] == Stay
      puts "@#{delear_name}".brown+": cards:[#{delear_cards}, count_cards:#{delear_count_cards}, note:#{Stay} "
      stay_or_hit = "S"  
    else
      printf " Delear Hit Card => "      
      hit_card delear_name,delear_cards,remainder_cards
      count_cards_value delear_hand 
      delear_count_cards = delear_hand[:count_cards]
      stay_or_hit = "H" 
      puts " cards:[#{delear_cards}, count_cards:#{delear_count_cards}"
    end
  end until stay_or_hit =~ /[S]/     
end

def show_hand_result(people)
  delear = people[:delear]
  delear_name = delear[:name]
  delear_hand = delear[:hands].last
  delear_cards = delear_hand[:cards]
  delear_count_cards = delear_hand[:count_cards]
  delear_vs_result = delear_hand[:vs_result]
  delear_note = delear_hand[:note]

  delear_vs_result.each do |k,v|
    puts "Player: "+"@#{k}".brown + " vs ".red + "Delear: "+"@#{delear_name}".brown + " "  
    people[:players].each do |player|
      player_name = player[:name]
      player_hand = player[:hands].last
      player_cards = player_hand[:cards]
      player_count_cards = player_hand[:count_cards]
      player_vs_result = player_hand[:vs_result]
      player_note = player_hand[:note]
      if player_name == k
        puts " |-> "+ "#{player_cards}".blue+ " vs " +  "#{delear_cards}".blue             
        tmp_str = "#{player_count_cards}".blue
        tmp_str = tmp_str + " #{player_note}"  if !player_note.empty? 
        tmp_str += " vs "
        tmp_str += "#{delear_count_cards}".blue
        tmp_str = tmp_str + " #{delear_note} " if !delear_note.empty?  
        puts " |-> "+tmp_str
        puts " |-> "+ "@#{player_name}".brown + " "+ "#{player_vs_result}".blue + " ; " + "@#{delear_name}".brown + " " + "#{v}".blue 
        puts " |   "
      end
    end
  end
end

def hist_show_hand_result(people)
  people[:players].each do |player|
    player_name = player[:name]
    puts "Player: "+"@#{player_name}".brown 
    round = 0
    player[:hands].each do |player_hand|
      player_cards = player_hand[:cards]
      player_count_cards = player_hand[:count_cards]
      player_vs_result = player_hand[:vs_result]
      player_note = player_hand[:note]
      tmp_str = " |-> Round-#{round +=1 }: "+ "#{player_cards}".blue         
      tmp_str += " #{player_count_cards}".blue
      tmp_str += " #{player_note}"  if !player_note.empty?                  
      tmp_str += " #{player_vs_result}".blue
      puts tmp_str      
    end
    puts " |   "
  end
end

# Here we go ^_^y
#--->>
if welcome? people
  while (true)
    system 'clear'
    puts "----------------------------------".green
    puts "| ".green+"Let's start to play Balckjack!"+" |".green
    puts "----------------------------------".green
    puts ""

    start_poker_party people,remainder_cards
    
    delear = people[:delear]
    delear_name = delear[:name]
    delear_hand = delear[:hands].last
    delear_cards = delear_hand[:cards]
    delear_count_cards = delear_hand[:count_cards]
    puts "Delear "+"@#{delear_name}".brown+" cards:"+"[#{delear_cards[0]},*]".blue
    puts ""
    
    stay_or_hit people,remainder_cards        
    win_or_lose people
    
    puts ""
    puts "-------------------------------------------------------------------------------".green
    show_hand_result people
    puts "-------------------------------------------------------------------------------".green
    puts ""  
    
    printf "(#{'E'.red})exit or any key to play again. "
    is_exit = gets.chomp.upcase
    if ['E'].include?(is_exit)
      system "clear"
      puts "Report".reverse_color
      puts "-------------------------------------------------------------------------------".green
      hist_show_hand_result people
      puts "-------------------------------------------------------------------------------".green
      puts ""  
      puts "Bye, Bye $-_-$ "  
      break
    end
  end
end
#--->>
