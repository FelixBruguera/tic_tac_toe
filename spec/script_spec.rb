require './script.rb'

describe Game do
    subject(:game_input) {described_class.new}

    describe '#check_duplicates' do
        context 'when given a new number' do
            it 'returns true' do
                expect(game_input.check_duplicates('9')).to eq(true)
            end
        end
        context 'when given duplicated input' do
            it 'returns the error message and board' do
                game_input.log_position('5','X')
                expect(game_input.log_position('5','X')).to eq(game_input.draw_board)
            end
        end
    end

    describe '#check_input' do
        context 'when given valid input' do
            it 'returns true' do
                expect(game_input.check_input('5')).to eq(true)
            end
        end

        context 'when given invalid input' do
            it 'does not return true' do
                expect(game_input.check_input('11')).not_to eq(true)
            end
        end
    end
    
    describe '#to_id' do
        it 'removes the number' do
            expect(game_input.to_id('5')[1]).not_to eq(Integer)
        end
    end

    describe '#log_position' do
        context 'when given a valid position' do
            it 'updates @played' do
                game_input.log_position('5','X') 
                expect(game_input.instance_variable_get(:@played)[:X]).to include(5)
            end

            it 'updates @turns' do
                game_input.log_position('5','X')
                expect(game_input.instance_variable_get(:@turns)[0]).to eq('X')
            end

            it 'updates @positions' do
                game_input.log_position('7','X')
                position = game_input.instance_variable_get(:@positions)[:X]
                expect(position.all? { |hash| hash.all? {|arr| arr[1].empty?}}).to eq(false)
            end
        end
    end

    describe '#draw_board' do
            it 'marks the played position' do
                game_input.log_position('7','X')
                expect(game_input.draw_board.any? {|arr| arr.include?('X')}).to eq(true)
            end
    end

    describe '#check_winner' do
        context 'when X wins' do
            it 'changes @check to true' do
                game_input.log_position('4','X')
                game_input.log_position('5','X')
                game_input.log_position('6','X')
                game_input.check_winner('X')
                expect(game_input.instance_variable_get(:@check)).to eq(true)
            end
        end
    end
end
