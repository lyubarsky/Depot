require 'spec_helper'

describe Product do

  let(:product) { FactoryGirl.build(:product) }

  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }
  it { should respond_to(:price) }
  it { should respond_to(:line_items) }
  it { should respond_to(:orders) }

  it { should be_valid }

  describe 'when title is not present' do
    before { product.title = ' '}
    it { should_not be_valid }
  end

  describe 'when a book with the title is already saved' do
    before do
      product_with_same_title = product.dup
      product_with_same_title.save
     end
   it { should_not be_valid }
  end

  describe 'when description is not present' do
    before { product.description = ' '}
    it { should_not be_valid }
  end

  describe 'image_url is not present' do
    before { product.image_url = ' ' }
    it { should_not be_valid }
  end

  describe 'when image_url format is not valid' do
    it 'should not be valid' do
      urls = %w[my.ico my.bmp my.tiff]
      urls.each do |invalid_url|
        product.image_url = invalid_url
        expect(product).not_to be_valid
      end
    end
  end

  describe 'when image_url format is valid' do
    it 'should be valid' do
      urls = %w[my.gif my.jpg my.jpeg my.png]
      urls.each do |valid_url|
        product.image_url = valid_url
        expect(product).to be_valid
      end
    end
  end

  describe 'when price is not present' do
    before { product.price = ' ' }
    it { should_not be_valid }
  end

  describe 'when price is not numerical' do
    before { product.price = 'one' }
    it { should_not be_valid }
  end

  describe 'when price is less then 0.01' do
    before { product.price = 0.001 }
    it { should_not be_valid }
  end

  describe 'when price is equal  0.01' do
    before { product.price = 0.01 }
    it { should be_valid }
  end

  describe 'order in products' do
    let!(:z_product) { FactoryGirl.create(:product, title: 'z') }
    let!(:a_product) { FactoryGirl.create(:product, title: 'a') }

    it 'must be ASC' do
      expect(Product.all.to_a).to eq [a_product, z_product]
    end
  end

end


