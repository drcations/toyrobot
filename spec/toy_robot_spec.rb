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
    
    describe '#perform' do
      subject { instance.perform }
  
      context 'with a test program 1' do
        let(:text) { 'PLACE 0,0,NORTH MOVE REPORT' }
  
        it 'returns a correct world' do
          expect { subject }.to output("0,1,NORTH\n").to_stdout
          expect(subject.coords).to eq [0, 1]
          expect(subject.direction).to eq 'NORTH'
        end
      end

      context 'with a test program 2' do
        let(:text) { 'PLACE 0,0,NORTH LEFT REPORT' }
  
        it 'returns a correct world' do
          expect { subject }.to output("0,0,WEST\n").to_stdout
          expect(subject.coords).to eq [0, 0]
          expect(subject.direction).to eq 'WEST'
        end
      end

      context 'with a test program 3' do
        let(:text) { 'PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT' }
  
        it 'returns a correct world' do
          expect { subject }.to output("3,3,NORTH\n").to_stdout
          expect(subject.coords).to eq [3, 3]
          expect(subject.direction).to eq 'NORTH'
        end
      end

      context 'with a difficult program' do
        let(:text) do
          'PLACE 4,4,NORTH MOVE MOVE MOVE MOVE LEFT MOVE ' \
          'LEFT MOVE LEFT MOVE RIGHT MOVE MOVE MOVE MOVE ' \
          'MOVE MOVE RIGHT MOVE RIGHT MOVE REPORT'
        end
  
        it 'returns a correct world' do
          expect { subject }.to output("3,1,NORTH\n").to_stdout
          expect(subject.coords).to eq [3, 1]
          expect(subject.direction).to eq 'NORTH'
        end
      end

      context 'when trying to escape east by north' do
        let(:text) do
          'PLACE 0,0,NORTH MOVE MOVE MOVE MOVE MOVE ' \
          'RIGHT MOVE MOVE MOVE MOVE MOVE ' \
          'REPORT'
        end
  
        it 'stays in the world' do
          expect { subject }.to output.to_stdout
          expect(subject.coords).to eq [4, 4]
          expect(subject.direction).to eq 'EAST'
        end
      end

      context 'when trying to escape west by south' do
        let(:text) do
          'PLACE 4,4,SOUTH MOVE MOVE MOVE MOVE MOVE ' \
          'RIGHT MOVE MOVE MOVE MOVE MOVE ' \
          'REPORT'
        end
  
        it 'stays in the world' do
          expect { subject }.to output.to_stdout
          expect(subject.coords).to eq [0, 0]
          expect(subject.direction).to eq 'WEST'
        end
      end

      context 'without any placement' do
        let(:text) { 'LEFT MOVE RIGHT MOVE REPORT' }
  
        it 'returns an empty world' do
          expect { subject }.to output("empty\n").to_stdout
          expect(subject.coords).to be nil
          expect(subject.direction).to be nil
        end
      end
  
      context 'with incorrect placement' do
        let(:text) { 'PLACE 0,5,NORTH MOVE RIGHT LEFT MOVE REPORT' }
  
        it 'returns an empty world' do
          expect { subject }.to output("empty\n").to_stdout
          expect(subject.coords).to be nil
          expect(subject.direction).to be nil
        end
      end
    end
  end
  