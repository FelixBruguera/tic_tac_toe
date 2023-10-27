class Game
    attr_accessor :positions, :turns, :played, :check

    def initialize
    @check = false
    @turns = []
    @played = {'O': [], 'X': []}
    @positions = {'O': [{"a":[],"b":[],"c":[]}, {"d":[], "e":[], "f":[]}, {"d1": [],"d2": []}],
                  'X': [{"a":[],"b":[],"c":[]}, {"d":[], "e":[], "f":[]}, {"d1": [],"d2": []}]}
    @ids = ["a_d1", "b_d2", "c_d3","a_e4", "b_e5", "c_e6","a_f7", "b_f8", "c_f9"]
    end
    
    def check_winner(player)
      for i in (0..2) do
        @positions[player.to_sym][i].keys.each do |key|
          @positions[player.to_sym][i][key].length == 3 ? @check = true : next
          end
        end
      if @check == true then return puts "Game over, #{player} won!" end
    end

    def check_duplicates(position)
      unless @played.nil?
        @played.each_key do |key|
          return puts "You can't play there, try again" if @played[key].include?(position.chomp.to_i)
        end
      end

      true
    end

    def check_input(position)
      return puts 'Wrong input' unless (1..9).include?(position.chomp.to_i)

      true
    end

    def to_id(position)
      row_col = @ids.filter { |id| id.include?(position.chomp.to_s) }[0].split('_')
      row_col[1] = row_col[1].tr('0-9', '')
      row_col
    end
    
    def log_position(position,player)
      return draw_board unless check_input(position)
      return draw_board unless check_duplicates(position)

      row_col = to_id(position)
      @turns[-1] == 'X' ? @turns.push('O') : @turns.push('X')
      @played[player.to_sym].push(position.chomp.to_i)
      @positions[player.to_sym][0][row_col[0].to_sym].push(1)
      @positions[player.to_sym][1][row_col[1].to_sym].push(1)
      @positions[player.to_sym][2][:d1].push(1) if ['1', '9'].include?(position.chomp)
      @positions[player.to_sym][2][:d2].push(1) if ['7', '3'].include?(position.chomp)
      if position.chomp == '5'
        @positions[player.to_sym][2][:d1].push(1)
        @positions[player.to_sym][2][:d2].push(1)
      end
      draw_board
      check_winner(player)
    end
    
    def draw_board
      nums = [1,2,3,4,5,6,7,8,9]
      nums.each_with_index do |num,ind|
        nums[ind] = 'O' if @played[:O].include?(num)
        nums[ind] = 'X' if @played[:X].include?(num)
      end
      nums = nums.each_slice(3).to_a
      nums.each { |num| puts num.join(' --- ').ljust(10) }
      puts "It's #{@turns[-1]}'s turn, choose a number"
      nums
    end

    def player_input
      pos = gets
      @turns[-1] == 'X' ? log_position(pos, @p1_letter) : log_position(pos, @p2_letter)
    end
    
    def play
      dice = rand(100)
      dice < 50 ? @turns.push('X') : @turns.push('O')
      draw_board
      while @check == false
        return puts "It's a draw!" if @turns.length == 10

        player_input
      end
    end

    def players(p1, p2)
      @p1_letter = p1
      @p2_letter = p2
    end
end

#game = Game.new
#game.players('X','O')
#game.play


  