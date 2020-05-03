# frozen_string_literal: true

# required by one2.rb

class Card
  attr_accessor :color
  attr_accessor :number
  attr_accessor :colorize

  def initialize(color, number)
    @color = color
    @number = number
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
    self
  end
end