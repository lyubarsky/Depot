require 'spec_helper'

describe 'Login Pages' do
#==========================================================

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe 'login page (Новая сессия)' do
#----------------------------------------------------------
    describe 'for not logged users' do
      before { visit login_path }

      it { should have_content('Новая сесcия') }
      it { should have_field('Имя') }
      it { should have_field('Пароль') }
      it { should have_button('Войти') }
      it { should_not have_button('Выйти') }
    end

    describe 'for logged users' do
      before do
        sign_in user
        visit login_path
      end

      it { should have_content('Новая сесcия') }
      it { should have_button('Выйти') }
    end

    describe 'logging of the user' do
      before { visit login_path }

      describe 'logging with wrong information' do
        before { click_button 'Войти' }

        it { should have_content('Новая сесcия') }
        it { should have_content('Неверная комбинация имени и пароля') }
      end

      describe 'logging with correct information' do
        before do
          fill_in 'Имя', with: user.name
          fill_in 'Пароль', with: user.password
          click_button 'Войти'
        end

        it { should have_content('Добро пожаловать') }
        it { should have_button('Выйти') }
      end
    end
  end

  describe 'admin page (Добро пожаловать)' do
#----------------------------------------------------------
    before do
      sign_in user
      visit admin_path
    end

    it { should have_content('Добро пожаловать') }
    it { should have_content("Сейчас #{Time.now}. У нас имеется 0 #{'order'.pluralize(0)}") }
    it { should have_link('Заказы', href: orders_path) }
    it { should have_link('Товары', href: products_path) }
    it { should have_link('Администраторы', href: users_path) }
    it { should have_button('Выйти') }

    specify 'link Заказы' do
      click_link 'Заказы'
      should have_content('Список заказов')
    end

    specify 'link Товары' do
      click_link 'Товары'
      should have_content('Список товаров')
    end

    specify 'link Администраторы' do
      click_link 'Администраторы'
      should have_content('Список администраторов')
    end

    specify 'button Выйти' do
      click_button 'Выйти'
      should have_content('Сеанс работы завершен')
      should have_content('Your Pragmatic Catalog')
    end
  end
end
