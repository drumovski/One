# frozen_string_literal: true

# required by one.rb

module CmdArguments
  module_function

  def choice_argument(first_arg)
    if first_arg == '-s'
      choice = 1
      system 'clear'
    else
      ARGV.clear
      choice = SplashScreen.splash_screen_choice
    end
    choice
  end

  def max_players_argument(first_arg, max)
    max_num_players = if first_arg == '-mp'
                        max[0].to_i
                      else
                        4
                      end
    max_num_players
  end

  def help_argument(first_arg)
    if first_arg == '-h'
      puts 'possible arguments:'
      puts "'-h' help"
      puts "'-s' skip splash screen"
      puts "'-mp' change maximum players from 4 to a value specified eg -mp 8"
      puts 'Warning, changing the maximum value to an invalid number or to a number too high (10+) will cause the game to behave erratically'
      exit
    end
  end

  def validate_arg(first_arg, max)
    validate_first_arg(first_arg, max)
  rescue InvalidArgumentError => e
    puts e.message
    exit
  end
end
