DEFAULT_NUMBER_OF_SLOTS = 7
DEFAULT_LENGTH_OF_SLOTS = 6




class Drawer 

  def self.draw(model)   
    columns = []
    column_size = model.max_slot_length 
    for i in 0..model.number_of_slots - 1
      column = []
      for j in 0..model.max_slot_length 
      	piece = model.slot_value(i,j)
        column << piece if piece != nil 
      end
      columns << column  
    end 
    columns.each do |e|
      e.map! {|x| x == 0 ? "R" : "Y"} 
      until e.length == column_size
        e << "O"
      end
      e.reverse!   
    end 
    
    for j in 0..column_size - 1
      puts "" 
      for i in 0..columns.length - 1 
        print columns[i][j] + " "
      end 
    end 
    puts ""

  end 




end 





class Dialogue 
  
  def self.prompt_move(model) 
    puts "it's player #{1 + model.turn} turn! make your move!"
    success = false 
    while success != true 
      move = gets.chomp 
      success = model.valid?(move)
      puts "error #{success}" if success != true   
    end
    move  
  end 

  def self.play_again
    success = false 
    while !success 
      puts "do you want to play again? Choose Y or N" 
      answer = gets.chomp
      if answer == 'y' || answer == 'n'
        success = true 
      end
    end  
      return true  if answer == 'y'
      return false if answer == 'n'
    end

  def self.winner_is(winner)
    puts "game is over, congratulations player #{winner}"
  end

  def self.intro
    puts "Welcome to connec 4! slots numbers are 1 through 7 from left to right"
  end 

  



end 

class Board 

  attr_reader :max_slot_length 

  def initialize(number_of_slots,length_of_slots)
    @board = Array.new(number_of_slots) { |e| [] }
    @max_slot_length = length_of_slots
  end


  def put_piece(slot,piece)
    #slot = slot.to_i
    return nil if slot < 0 || slot > (@board.length - 1) 
    return nil if @board[slot].length == self.max_slot_length 
    @board[slot] << piece 
  end

  def number_of_pieces_in_slot(slot)
    @board[slot].length 
  end

  def number_of_slots
    @board.length
  end 

  def slot_value(slot,position)
    return nil if slot < 0 || slot > @board.length - 1 
    return nil if position < 0 || position > @max_slot_length - 1 
    @board[slot][position]   
  end

  def build_random_board
    @board.each do |e|
      for i in 0..@max_slot_length - 1
        coin_toss = rand()*3 
        e << 0 if coin_toss > 0 && coin_toss < 1 
        e << 1 if coin_toss >1  && coin_toss < 2
      end 
    end  


  end 


end


class Model 
  
 

  def initialize(number_of_slots,length_of_slots) 
    @board_object = Board.new(number_of_slots,length_of_slots) 
  end 
  
  def valid?(number)
    number = number.to_i 
    array = [] 
    for i in 0..self.number_of_slots - 1 
      array << i + 1 
    end 
    return "invalid number" if array.include?(number) == false  
    if @board_object.slot_value(number - 1,self.max_slot_length - 1) != nil 
      return "full slot" 
    end 
    true 
  end 

  def max_slot_length
    @board_object.max_slot_length
  end 

  def number_of_slots
    @board_object.number_of_slots
  end

  def turn
    sum = 0
    for i in 0..self.number_of_slots - 1 
      for j in 0..self.max_slot_length - 1 
        sum += 1 if @board_object.slot_value(i,j) != nil
      end 
    end 
    sum%2 # if 0 it's 1's turn, if 1 it's 0's turn 
  end 
  

  def put_piece(slot)
    slot = slot.to_i - 1 
    @board_object.put_piece(slot,self.turn) 
  end 

  def build_random_board
    @board_object.build_random_board
  end  

  def slot_value(slot,position)
    @board_object.slot_value(slot,position)
  end
  

  def determine_winner
    for i in 0..self.number_of_slots - 1
      for j in 0..self.max_slot_length - 1
        s = self.slot_value(i,j)      
        
        v1 = self.slot_value(i,j+1)  
        v2 = self.slot_value(i,j+2)  
        v3 = self.slot_value(i,j+3) 

        h1 = self.slot_value(i+1,j) 
        h2 = self.slot_value(i+2,j) 
        h3 = self.slot_value(i+3,j) 

        d1 = self.slot_value(i+1,j+1) 
        d2 = self.slot_value(i+2,j+2) 
        d3 = self.slot_value(i+3,j+3)
        
        d4 = self.slot_value(i+1,j-1)
        d5 = self.slot_value(i+2,j-2)
        d6 = self.slot_value(i+3,j-3)
        
        array_v = [v1,v2,v3]
        array_h = [h1,h2,h3]
        array_d1 = [d1,d2,d3]
        array_d2 = [d4,d5,d6]

        if array_v.all? {|e| e == s} || array_h.all? {|e| e == s} || array_d1.all? {|e| e == s} || array_d2.all? {|e| e == s} 
          return s if s !=nil 
        end 

      end 
    end
    return "no winner"
  end

  def game_over?
    if self.determine_winner == 1 || self.determine_winner == 0
      return true
    end 
    for i in 0..self.number_of_slots - 1
      piece = slot_value(i,self.max_slot_length - 1) 
      return false if piece == nil 
    end  
    true 
  end 







end 

end_game = false 
while !end_game
  model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
  Dialogue.intro
  until model.game_over? 
    Drawer.draw(model)
    slot = Dialogue.prompt_move(model)
    model.put_piece(slot) 
  end 
  Drawer.draw(model)
  Dialogue.winner_is( model.determine_winner ) 
  end_game = !Dialogue.play_again
end 