module ZooniverseSocial
  RSpec.describe TaskObserver do
    let(:task){ double add_observer: true, shutdown: true }
    let(:restart){ double call: true }
    let(:subject){ TaskObserver.new task, restart }

    describe '#initialize' do
      it 'should observer the task' do
        expect(task).to receive(:add_observer).with TaskObserver
        subject
      end
    end

    describe '#update' do
      context 'without a timeout error' do
        before(:each){ subject.update 1, 2, 3 }

        it 'should not shutdown the task' do
          expect(task).to_not have_received :shutdown
        end

        it 'should not restart the timer' do
          expect(restart).to_not have_received :call
        end
      end

      context 'with a timeout error' do
        before(:each){ subject.update 1, 2, Concurrent::TimeoutError.new }

        it 'should shutdown the task' do
          expect(task).to have_received :shutdown
        end

        it 'should restart the timer' do
          expect(restart).to have_received :call
        end
      end
    end
  end
end
