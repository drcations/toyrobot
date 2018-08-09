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
  
      def initialize(coords, direction)
        @coords = coords
        @direction = direction
      end

      def apply(command, *args)
        case command
        when :place then place(*args)
        when :move then move
        when :turn then turn(args[0])
        when :report then report
        end
      end