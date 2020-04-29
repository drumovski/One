# frozen_string_literal: true

# required by one2.rb

class Card
  attr_accessor :color
  attr_accessor :number
  attr_reader :colorize

  def initialize(color, number, colorize)
    @color = color
    @number = number
    @colorize = colorize
    self
  end
end