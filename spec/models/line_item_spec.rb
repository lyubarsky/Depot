require 'spec_helper'

describe LineItem do

  subject { @line_item = LineItem.new}

  it { should respond_to(:cart_id) }
  it { should respond_to(:product_id) }
  it { should respond_to(:quantity) }
  it { should respond_to(:cart) }
  it { should respond_to(:product) }
  it { should respond_to(:order) }
end
