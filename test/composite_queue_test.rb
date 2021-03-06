require_relative 'test_helper'

describe Adrian::CompositeQueue do
  before do
    @q1 = Adrian::ArrayQueue.new
    @q2 = Adrian::ArrayQueue.new
    @q  = Adrian::CompositeQueue.new(@q1, @q2)
  end

  describe "popping" do
    it 'should return nil when all queues are empty' do
      @q.pop.must_be_nil
    end

    it 'should return an item from the first queue that has items' do
      @q1.push(1)
      @q1.push(2)
      @q2.push(3)
      @q2.push(4)

      @q.pop.value.must_equal(1)
      @q.pop.value.must_equal(2)
      @q.pop.value.must_equal(3)
      @q.pop.value.must_equal(4)
      @q.pop.must_be_nil
      @q1.pop.must_be_nil
      @q2.pop.must_be_nil
    end

    it 'sets the original queue on the item' do
      @q1.push(1)
      @q2.push(2)

      @q.pop.queue.must_equal @q1
      @q.pop.queue.must_equal @q2
    end
  end

  describe "pushing" do
    it "should not be allowed" do
      lambda { @q.push(1) }.must_raise(RuntimeError)
    end
  end
end
