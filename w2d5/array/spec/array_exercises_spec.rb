require 'rspec'
require 'array_exercises'

RSpec.describe Array do
  describe "#my_uniq" do
    it "should eliminate duplicates" do
      expect( [1,2,3,1].my_uniq).to eq([1,2,3])
    end

    it "returns the same array if it is already unique" do
      expect([1,2,3].my_uniq).to eq([1,2,3])
    end

    it "doesn't modify the original array" do
      arr = [1,2,3,1]
      arr.my_uniq
      expect(arr).to eq([1,2,3,1])
    end
  end

  describe "#two_sum" do
    it "finds a pair that sum to zero" do
      expect([1,2,3,-1].two_sum).to eq([[0,3]])
    end

    it "returns pairs in dictionary order" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end

    it "returns an empty array if there are no pairs" do
      expect([1,2,3,4,5].two_sum).to eq([])
    end
  end

  describe "#my_transpose" do
    let(:matrix) { [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ] }

    it "transposes a matrix" do
      transposed_matrix = [
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
      ]
      expect(matrix.my_transpose).to eq transposed_matrix
    end

    it "doesn't mutate the array" do
      my_matrix = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
      my_matrix.my_transpose
      expect(my_matrix).to eq matrix
    end

    it "transposing twice returns the original matrix" do
      expect(matrix.my_transpose.my_transpose).to eq matrix
    end
  end

  describe "#stock_picker" do

    it "returns two valid indices" do
      arr = [23, 45, 16, 64, 1, 24]
      best_days = arr.stock_picker
      expect( best_days.length ).to eq 2
      expect( best_days.none?{|day| arr[day].nil?} ).to be_truthy
    end

    it "returns the most profitable pair of days" do
      expect([23, 45, 16, 64, 1, 24].stock_picker).to eq [2,3]
    end

  end

end
