module Game
    attr_accessor :positions, :turns, :played, :check
    @@check = false
    @@turns= []
    @@played = {'O': [], 'X': []}
    @@positions = {'O': [{"a":[],"b":[],"c":[]}, {"d":[], "e":[], "f":[]}, {"d1": [],"d2": []}],
                   'X': [{"a":[],"b":[],"c":[]}, {"d":[], "e":[], "f":[]}, {"d1": [],"d2": []}]}
    @@IDS = ["a_d1", "b_d2", "c_d3","a_e4", "b_e5", "c_e6","a_f7", "b_f8", "c_f9"]
    
    def check_winner(player)
      for i in (0..2) do
        @@positions[player.to_sym][i].keys.each do |key|
          @@positions[player.to_sym][i][key].length == 3 ? @@check = true : next
          end
        end
      if @@check == true then return puts "Game over, #{player} won!" end
    end
    
    def log_position(position,player)
      # check for errors
      @@played.keys.each do |key|
        if @@played[key].include?position.chomp.to_i
          puts "You can't play there, try again"
          return Game.draw_board
        end
      end
      if !(1..9).include?(position.chomp.to_i)
        puts "Wrong input"
        return Game.draw_board 
      end
      # log position
      row_col = @@IDS.filter {|id| id.include?(position.chomp.to_s)}[0].split("_")
      row_col[1] = row_col[1].tr("0-9","")
      @@turns[-1] == 'X' ? @@turns.push('O') : @@turns.push('X')
      @@played[player.to_sym].push(position.chomp.to_i)
      @@positions[player.to_sym][0][row_col[0].to_sym].push(1)
      @@positions[player.to_sym][1][row_col[1].to_sym].push(1)
      if ["1","9"].include?(position.chomp) then @@positions[player.to_sym][2][:d1].push(1) end
      if ["7","3"].include?(position.chomp) then @@positions[player.to_sym][2][:d2].push(1) end
      if position.chomp == "5" then
        @@positions[player.to_sym][2][:d1].push(1)
        @@positions[player.to_sym][2][:d2].push(1)
      end
      Game.draw_board
      check_winner(player)
    end
    
    def self.draw_board
      nums = [1,2,3,4,5,6,7,8,9]
      nums.each_with_index {|num,ind| @@played[:O].include?(num) ? nums[ind] = 'O' : next}
      nums.each_with_index {|num,ind| @@played[:X].include?(num) ? nums[ind] = 'X' : next}
      nums = nums.each_slice(3).to_a
      nums.each {|num| puts num.join(" --- ").ljust(10)}
      puts "It's #{@@turns[-1]}'s turn, choose a number"
    end
    
    def self.play(player1,player2)
      dice = rand(101)
      dice < 50 ? @@turns.push('X') : @@turns.push('O')
      Game.draw_board()
      while @@check == false do
        if @@turns.length == 10 then return puts "It's a draw!" end
        pos = gets
        @@turns[-1] == "X" ? player1.log_position(pos,X.letter) : player2.log_position(pos,O.letter)
      end
    end    
  end
    
  class Player
    include Game
    attr_reader :letter
    def initialize(letter)
      @letter = letter
    end
  end
  
  X = Player.new("X")
  O = Player.new("O")
  Game.play(X,O)
    
  