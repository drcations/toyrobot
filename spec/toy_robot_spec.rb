RSpec.describe ToyRobot::Program do
    subject { instance }
  
    let(:instance) { described_class.new(text) }