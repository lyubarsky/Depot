require 'spec_helper'

describe Cart do

  before { @cart = Cart.new }

  subject { @cart }

  it { should respond_to(:line_items) }

  describe 'line_item associations' do
    before do
      @cart.save
      @cart.line_items.create
    end

    it 'should destroy associated line_items' do
      expect(@cart.line_items).not_to be_empty
      @cart.destroy
      expect(LineItem.where(cart: @cart)).to be_empty
    end
  end

end
