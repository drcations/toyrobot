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
  
      private
  
      def place(*args)
        coords, direction = args
  
        if self.class.valid_coords?(coords)
          self.class.new(coords, direction)
        else
          self
        end
      end
  
      def move
        if !@coords
          self
        else
          coords =
            case @direction
            when 'NORTH' then [@coords[0], @coords[1] + 1]
            when 'EAST' then [@coords[0] + 1, @coords[1]]
            when 'SOUTH' then [@coords[0], @coords[1] - 1]
            when 'WEST' then [@coords[0] - 1, @coords[1]]
            else raise "Wrong direction #{@direction}"
            end
  
            if self.class.valid_coords?(coords)
              self.class.new(coords, @direction)
            else
              self
            end
          end
        end
  
      def turn(direction)
        if !@coords
          self
        else
          old_index = DIRECTIONS.index(@direction)
  
          raise "Wrong direction #{@direction}" unless old_index
  
          shift =
            case direction
            when :left then -1
            when :right then 1
            end
  
          new_index = (old_index + shift) % 4
          new_direction = DIRECTIONS[new_index]
        
          self.class.new(@coords, new_direction)
        end
     end
  
     def report

        if !@coords
          puts 'empty'
        else
          puts((@coords + [@direction]).join(','))
        end
  
        self
      end
    end
 end
          