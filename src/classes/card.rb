# frozen_string_literal: true

# required by one.rb

class Card
  attr_accessor :color
  attr_accessor :number
  attr_accessor :colorize
  attr_accessor :score

  def initialize(color, number)
    @color = color
    @number = number
    @colorize = :magenta
    @score = 0
    self
  end

  def set_color
    case @color
    when 'Red'
      @colorize = :light_red
    when 'Blue'
      @colorize = :light_blue
    when 'Yellow'
      @colorize = :light_yellow
    when 'Green'
      @colorize = :light_green
    when 'Wild'
      @colorize = :magenta
    end
    @colorize
  end

end