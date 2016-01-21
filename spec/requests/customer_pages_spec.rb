require 'spec_helper'


describe 'CustomerPages' do
#==========================================================
  let!(:product) { FactoryGirl.create(:product) }

  subject { page }

  describe 'customer page' do
#----------------------------------------------------------
    before { visit store_path }

    it 'contains the following elements' do
      should have_content('Pragmatic Catalog')
      should have_selector('h3', text: product.title)
      should have_content(product.description)
      should have_content('Корзина пуста')
      should have_content(product.price)
      should have_button('Добавить в корзину')
      should have_button('Убрать из корзины')
      should have_link('Home', href: 'http://www....')
      should have_link('Questions', href: 'http://www..../faq')
      should have_link('News', href: 'http://www..../news')
      should have_link('Contact', href: 'http://www..../contact')
    end

    specify 'button Добавить в корзину' do
      expect { click_button 'Добавить в корзину' }.to change(LineItem, :count).by(1)

      line_item = product.line_items.last

      should have_content('Ваша корзина')
      should have_content(line_item.quantity)
      should have_selector('td', text: product.title)
      should have_content(number_to_currency(line_item.total_price))
      should have_button('Заказать')
      should have_button('Очистить корзину')
    end

    specify 'button Убрать из корзины' do
      2.times { click_button 'Добавить в корзину' }
      expect(product.line_items.last.quantity).to eq 2

      click_button 'Убрать из корзины'
      expect(product.line_items.last.quantity).to eq 1

      click_button 'Убрать из корзины'
      expect(product.line_items).to be_empty

      should have_content('Корзина пуста')
      should_not have_button('Заказать')
      should_not have_button('Очистить корзину')
    end

    specify 'button Очистить' do
      click_button 'Добавить в корзину'
      should have_content('Ваша корзина')

      click_button 'Очистить'
      expect(product.line_items).to be_empty
      should have_content('Корзина пуста')
    end

    specify 'button Заказать' do
      click_button 'Добавить в корзину'
      click_button 'Заказать'

      should have_content('Новый заказ')
    end
  end

  describe 'new order page' do
    #------------------------------------------------------
    before do
      visit store_path
      click_button 'Добавить в корзину'
      click_button 'Заказать'
    end

    it 'contains the following elements' do
      should have_content('Новый заказ')
      should have_field('Name')
      should have_field('Address')
      should have_field('Email')
      should have_select('Pay type')
      should have_button('Сделать заказ')
      should have_link('Назад')
    end

    specify 'button Сделать заказ with wrong information' do
      click_button('Сделать заказ')
      should have_content('Name can\'t be blank')
      should have_content('Address can\'t be blank')
      should have_content('Email can\'t be blank')
    end

    specify 'button Сделать заказ with correct information' do

      fill_in 'Name', with: 'new_name'
      fill_in 'Address', with: 'new_address'
      fill_in 'Email', with: 'new_email'
      select('Check', from: 'Pay type')

      expect { click_button('Сделать заказ') }.to change(Order, :count).by(1)

      should have_content('Your Pragmatic Catalog')
      should have_content('Спасибо за заказ')
    end

    specify 'link Назад' do
      click_link('Назад')
      should have_content('Your Pragmatic Catalog')
    end
  end
end
