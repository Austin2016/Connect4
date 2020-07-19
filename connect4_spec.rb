require './connect4'






describe Board do 
  describe '#put_piece' do
    it 'puts a piece' do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      model.put_piece(1)
      expect( model.turn  ).to eql(1)
    end 
  end 
  describe '#number_of_pieces_in_slot' do
    it  'tells length of slot' do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      expect( model.turn ).to eql(0)
    end 
  end
  describe '#slot_value' do
  	it 'tells the value at a certain place in a slot' do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      model.put_piece(1)
      expect( model.slot_value(0,0) ).to eql(0)
    end 
  end

end 

describe Model do 
  describe '#game_over?' do
    it "make sure the game is over when a nw to se daiginal is made " do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      model.put_piece(1)
      model.put_piece(7)
      model.put_piece(6)
      model.put_piece(6)
      model.put_piece(5)
      model.put_piece(5)
      model.put_piece(4)
      model.put_piece(5)
      model.put_piece(4)
      model.put_piece(4)
      model.put_piece(1)
      model.put_piece(4)
      expect(model.game_over?).to eql(true)
      expect(model.determine_winner).to eql(1)
    end 
  end
  describe '#game_over?' do
    it "knows the game is over for a sw to ne diaginal" do 
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      model.put_piece(1)
      model.put_piece(2)
      model.put_piece(2)
      model.put_piece(3)
      model.put_piece(3)
      model.put_piece(7)
      model.put_piece(3)
      model.put_piece(4)
      model.put_piece(4)
      model.put_piece(4)
      model.put_piece(4)
      expect(model.game_over?).to eql(true)
      expect(model.determine_winner).to eql(0)
    end 
  end 
  describe '#game_over?' do
    it "knows when game should end" do   
    model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
    expect( model.game_over? ).to eql(false)
    end 
  end

end 


