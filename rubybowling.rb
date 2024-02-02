class Frame
    attr_accessor :top, :bottom, :bonus, :special, :previous_frame
  
    def initialize(previous_frame = nil)
      @top = 0
      @bottom = 0
      @bonus = 0
      @special = "none"
      @previous_frame = previous_frame
    end
  
    def score
      @top + @bottom + @bonus
    end
  end
  
  class Player
    attr_accessor :name, :frames, :total_score
  
    def initialize(name)
      @name = name
      @frames = []
      @total_score = total_score
    end
  
    def add_frame(frame)
      @frames << frame
    end
  
    def total_score
      total = 0
      @frames.each do |frame|
        total += frame.top + frame.bottom + frame.bonus
      end
      total
    end
  
    def apply_bonus(frame_index, bonus)
      @frames[frame_index].bonus += bonus
      @total_score += bonus
    end
  end
  
  class BowlingGame
    attr_accessor :players, :current_player_index, :current_frame_index
  
    def initialize
      @players = []
      @current_player_index = 0
      @current_frame_index = 0
    end
  
    def add_player(name)
      @players << Player.new(name)
    end
  
    def start
      while @current_frame_index < 10
        @players.each do |player|
          roll(player)
          announce_frame_score(player)
        end
        @current_frame_index += 1
      end
  
      display_results
    end
  
    private

    def roll(player)
        puts "#{player.name}, it's your turn. Enter a number between 0 and 10 for frame #{@current_frame_index + 1}, top:"
      
        roll1 = nil
        roll2 = nil
        loop do
          roll1 = gets.to_i
      
          unless (0..10).include?(roll1)
            puts "Invalid input. Please enter a number between 0 and 10."
            next
          end
      
          break
        end
      
        previous_frame = player.frames.last if player.frames.any?
      
        frame = Frame.new(previous_frame)
        frame.top = roll1
      
        if (frame.top < 10) || current_frame_index == 9
          pin_text = frame.top == 10 ? 10 : 10 - frame.top
          puts "#{player.name}, enter a number between 0 and #{pin_text} for frame #{@current_frame_index + 1}, bottom:"
      
          loop do
            roll2 = gets.to_i
      
            unless (0..pin_text).include?(roll2)
              puts "Invalid input. Please enter a number between 0 and #{pin_text}."
              next
            end
      
            break
          end
      
          frame.bottom = roll2
        else
          frame.bottom = 0
        end
      
        if (frame.top || frame.top + frame.bottom == 10) && current_frame_index == 9
          puts "#{player.name}, enter a number between 0 and 10 for frame #{@current_frame_index + 1}, bonus:"
          frame.bonus = gets.to_i
        end
      
        apply_special_bonus(frame, previous_frame)
      
        player.add_frame(frame)
      end
  
    def apply_special_bonus(current_frame, previous_frame)
      if current_frame.top == 10
        current_frame.special = "strike"
      elsif current_frame.top + current_frame.bottom == 10
        current_frame.special = "spare"
      end
  
      if previous_frame&.special == "strike"
        previous_frame.bonus += current_frame.top + current_frame.bottom
  
        two_frames_ago = previous_frame.previous_frame
        two_frames_ago.bonus += current_frame.top if two_frames_ago&.special == "strike"
      elsif previous_frame&.special == "spare"
        previous_frame.bonus += current_frame.top
      end
    end
  
    def announce_frame_score(player)
      current_frame = player.frames[@current_frame_index]
      puts "#{player.name}, your score for frame #{@current_frame_index + 1} is #{current_frame.score}"
  
      if current_frame.special == "strike"
        puts "You got a Strike!"
      elsif current_frame.special == "spare"
        puts "You got a Spare!"
      end
    end
  
    def display_results
      puts "Game Over! Final Scores:"
  
      sorted_players = @players.sort_by { |player| -player.total_score }
  
      sorted_players.each do |player|
        puts "#{player.name}: #{player.total_score}"
  
        puts "Frames:"
        player.frames.each_with_index do |frame, index|
          puts "Frame #{index + 1}: Top - #{frame.top}, Bottom - #{frame.bottom}, Bonus - #{frame.bonus}"
        end
  
        puts "\n"
      end
  
      puts "The winner is #{sorted_players[0].name} with a score of #{sorted_players[0].total_score}!"
    end
  end
  
  # Main Program
  
  bowling_game = BowlingGame.new
  
  4.times do |i|
    puts "Enter name for player #{i + 1}:"
    name = gets.chomp
    bowling_game.add_player(name)
  
    if i < 3
      puts "Would you like to add another player? [y/n]"
      response = gets.chomp.downcase
      break if response != 'y'
    end
  end
  
  bowling_game.start
  