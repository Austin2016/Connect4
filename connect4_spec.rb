require './connect4'






describe Board do 
  describe '#put_piece' do
    it 'puts a piece' do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      model.board_object.put_piece(0,model)
      expect( model.board_object.number_of_pieces_in_slot(0)  ).to eql(1)
    end 
  end 
  describe '#number_of_pieces_in_slot' do
    it  'tells length of slot' do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      expect( model.board_object.number_of_pieces_in_slot(0) ).to eql(0)
    end 
  end
  describe '#slot_value' do
  	it 'tells the value at a certain place in a slot' do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      model.board_object.put_piece(0,model)
      expect( model.board_object.slot_value(0,0) ).not_to eql(1)
    end 
  end

end 

describe Model do 
  describe '#turn' do
    it "make sure the game has the right person's turn" do
      model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
      expect(model.turn).to eql(0)
      model.board_object.put_piece(0,model)
      expect(model.turn).to eql(1)
    end 
  end
  describe '#game_over?' do
    it "knows when game should end" do   
    model = Model.new(DEFAULT_NUMBER_OF_SLOTS,DEFAULT_LENGTH_OF_SLOTS)
    expect( game_over).to eql(false)
    end 
  end

end 


