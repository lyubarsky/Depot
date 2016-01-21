require 'spec_helper'

describe Order do

  let(:order) { FactoryGirl.build(:order) }

  subject { order }

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:email) }
  it { should respond_to(:pay_type) }
  it { should respond_to(:line_items) }

  it { should be_valid }

  describe 'when name is not present' do
    before { order.name = '' }
    it { should_not be_valid }
  end

  describe 'when address is not present' do
    before { order.address = '' }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { order.email = '' }
    it { should_not be_valid }
  end

  describe 'the type of payment' do

    it 'in case of the correct type of payment' do
      Order::PAYMENT_TYPES.each do |pay_type|
        order.pay_type = pay_type
        should be_valid
      end
    end

    it 'in case of the wrong type of payment' do
      payment_types = ['translation of promissory', 'note', 'collection',
                       'letter of credit']
      payment_types.each do |pay_type|
        order.pay_type = pay_type
        should_not be_valid
      end
    end
  end

  describe 'line_item associations' do
    before do
      order.save
      order.line_items.create
    end

    it 'should destroy associated line_items' do
      expect(order.line_items).not_to be_empty
      order.destroy
      expect(LineItem.where(order: order)).to be_empty
    end
  end
end
