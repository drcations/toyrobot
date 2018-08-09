module ToyRobot
    class World
      DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  
      attr_reader :coords, :direction
  
      class << self        
        
        def empty
          new(nil, nil)
        end
   
        def valid_coords?(coords)
          (0..4).cover?(coords[0]) && (0..4).cover?(coords[1])
        end
      end