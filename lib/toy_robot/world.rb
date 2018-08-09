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
  