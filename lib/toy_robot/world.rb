require 'toy_robot/world'

module ToyRobot
    class Program
      attr_reader :commands
  
      def initialize(text)
        
        tokens = text.split(/\s+/m)
  
        @commands = []

        until tokens.empty?
          token = tokens.shift
  
          case token
          when 'PLACE'
            
            args = tokens.shift
            x_string, y_string, direction = args.split(',')
            x, y = [x_string, y_string].map(&:to_i)
            @commands << [:place, [x, y], direction]
          when 'MOVE'
            @commands << :move
          when 'LEFT'
            @commands << [:turn, :left]
          when 'RIGHT'
            @commands << [:turn, :right]
          when 'REPORT'
            @commands << :report
          end
        end
      end     
     
      def perform
        
        @commands.reduce(ToyRobot::World.empty) do |current_world, command|
          current_world.apply(*command)
        end
      end
    end
  end
     