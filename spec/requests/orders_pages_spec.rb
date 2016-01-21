require 'spec_helper'

describe 'Orders Pages' do
#==========================================================
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user}

  subject { page }

  describe 'orders page (Список заказов)' do
    #--------------------------------------------------------
    let!(:order) { FactoryGirl.create(:order) }
    let(:product) { FactoryGirl.create(:product) }
    let(:cart) { FactoryGirl.create(:cart) }
    let(:line_item) { FactoryGirl.build(:line_item,
                                        cart_id: cart.id, product_id: product.id) }

    before do
      register(cart)
      visit orders_path
    end

    it do
      should have_content('Список заказов')
      should have_content(order.name)
      should have_content(order.address)
      should have_content(order.email)
      should have_content(order.pay_type)
      should have_link('Show', href: order_path(order))
      should have_link('Edit', href: edit_order_path(order))
      should have_link('Destroy', href: order_path(order))
      should have_link('New Order', href: new_order_path)
    end

    specify 'link Show' do
      click_link 'Show'
      should have_content('Заказ № ' + order.id.to_s)
    end

    specify 'link Edit' do
      click_link 'Edit'
      should have_content('Editing Order')
    end

    specify 'link Destroy' do
      expect { click_link('Destroy') }.to change(Order, :count).by(-1)
      should have_content('Список заказов')
      should have_content('Заказ успешно уничтожен')
    end

    specify 'link New Order with empty cart' do
      click_link 'New Order'
      should have_content('Your Pragmatic Catalog')
      should have_content('Ваша корзина пуста')
    end


    specify 'link New Order with full cart' do
      line_item.save
      click_link 'New Order'
      should have_content('Новый заказ')
    end

    # describe 'new order page' do
      #------------------------------------------------------
      # In customer_pages_spec.rb
    # end

    describe 'page Show' do
      #--------------------------------------------------------------------
      before { visit order_path(order) }

      it do
        should have_content('Заказ № ' + order.id.to_s)
        should have_content('Name: ' + order.name)
        should have_content('Address: ' + order.address)
        should have_content('Email: ' + order.email)
        should have_content('Pay type: ' + order.pay_type)
        should have_link('Edit', href: edit_order_path(order))
        should have_link('Back', href: orders_path)
      end

      specify 'link Back' do
        click_link('Back')
        should have_content('Список заказов')
      end

      specify 'link Edit' do
        click_link('Edit')
        should have_content('Editing Order')
      end
    end

    describe 'page Edit' do
      #------------------------------------------------------
      before { visit edit_order_path(order) }

      it do
        should have_content('Editing Order')
        should have_field('Name', visible: order.name)
        should have_field('Address', visible: order.address)
        should have_field('Email', visible: order.email)
        should have_select('Pay type', visible: order.pay_type)
        should have_button('Сделать заказ')
        should have_link('Show', href: order_path(order))
        should have_link('Back', href: orders_path)
      end

      specify 'button Сделать заказ' do
        click_button('Сделать заказ')
        should have_content('Заказ № ' + order.id.to_s)
        should have_content('Заказ успешно обновлен')
      end

      specify 'link Show' do
        click_link 'Show'
        should have_content('Заказ № ' + order.id.to_s)
      end

      specify 'link Back' do
        click_link 'Back'
        should have_content('Список заказов')
      end
    end
  end
end