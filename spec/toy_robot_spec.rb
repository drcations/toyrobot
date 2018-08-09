RSpec.describe ToyRobot::Program do
    subject { instance }
  
    let(:instance) { described_class.new(text) }

    describe '#initialize' do
      let(:text) { 'PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT' }
  
      it 'converts plaintext into a sequence commands' do
        expect(subject.commands).to eq [
          [:place, [1, 2], 'EAST'],
          :move,
          :move,
          [:turn, :left],
          :move,
          :report
        ]
      end
    end