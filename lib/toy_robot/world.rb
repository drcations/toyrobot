require 'toy_robot/world'

module ToyRobot
    class Program
      attr_reader :commands
  
      def initialize(text)