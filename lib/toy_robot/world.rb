module ToyRobot
    class World
      DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  
      attr_reader :coords, :direction
  
      class << self