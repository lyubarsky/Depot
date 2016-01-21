require 'spec_helper'

describe LineItemsController do
  let(:product) { FactoryGirl.create(:product)}

  describe 'creating a line_item with Ajax - button Добавить в корзину' do

    it 'should increment the Cart and the LineItem counts' do
      expect do
        xhr :post, :create, product_id: product
      end.to change(LineItem, :count).by(1)
    end

    it 'should respond with success' do
      xhr :post, :create, product_id: product
      expect(response).to be_success
    end
  end

  describe 'destroying a line_item with Ajax - button Убрать из корзины' do
    let(:cart) { FactoryGirl.create(:cart) }
    let(:line_item) { FactoryGirl.create(:line_item, product_id: product.id, cart_id: cart.id) }

    it 'should decrement the lineItems count' do
      xhr :delete, :destroy, product_id: product
      change(LineItem, :count).by(-1)
    end

    it 'should respond with success' do
      xhr :delete, :destroy, product_id: product
      expect(response).to be_success
    end
  end
end

describe CartsController do
  let!(:cart) { FactoryGirl.create(:cart) }

  describe 'remove all line_items - button Очистить корзину' do
    before { session[:cart_id] = cart.id }

    it 'should destroy cart' do
      expect do
        xhr :delete, :destroy, id: cart.id
      end.to change(Cart, :count).by(-1)
    end

    it 'should respond with success' do
      xhr :delete, :destroy, id: cart
      expect(response).to be_success
    end
  end
end