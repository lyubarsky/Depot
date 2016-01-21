require 'spec_helper'

describe 'Users Pages' do
#==========================================================
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user}

  subject { page }

  describe 'users page (Список администраторов)' do
  #--------------------------------------------------------
    let!(:another_user) { FactoryGirl.create(:user, name: 'another_user') }

    before { visit users_path }

    it do
      should have_content('Список администраторов')
      should have_content('Имя')
      should have_link('Show', href: user_path(user))
      should have_link('Edit', href: edit_user_path(user))
      should have_link('Destroy', href: user_path(user))
      should have_link('New User', href: new_user_path)
    end

    specify 'link Show' do
      click_link('Show', href: user_path(user))
      should have_content("Имя: #{user.name}")
      should have_link('Edit', href: edit_user_path(user))
      should have_link('Back', href: users_path)
    end

    specify 'link Edit' do
      click_link('Edit', href: edit_user_path(user))
      should have_content('Editing User')
    end

    specify 'link Destroy' do
      expect do
        click_link('Destroy', href: user_path(another_user))
        end.to change(User, :count).by(-1)
        should have_content('Список администраторов')
        should have_content("Администратор #{another_user.name} удален")

      expect do
        click_link('Destroy')
        end.to change(User, :count).by(0)
        should have_content('Последний администратор не может быть удален')
      end

    specify 'link new user' do
      click_link 'New User'
      should have_content 'New User'
    end
  end

  describe 'new user page' do
  #--------------------------------------------------------
    before { visit new_user_path }

    it do
      should have_content 'New User'
      should have_content 'Введите сведения о пользователе'
      should have_field('Имя')
      should have_field('Пароль')
      should have_field('Подтверждение')
      should have_button('Create User')
      should have_link('Back', href: users_path)
    end

    specify 'button Create User' do
      expect do
        fill_in 'Имя', with: 'new_name'
        fill_in 'Пароль', with: 'new_password'
        fill_in 'Подтверждение', with: 'new_password'
        click_button('Create User')
      end.to change(User, :count).by(1)

      should have_content('Список администраторов')
      should have_content('Пользователь new_name был успешно создан')
      should have_content('Имя')
      should have_content('new_name')
    end
  end

  describe 'user show page' do
  #------------------------------------------------------
    before { visit user_path(user) }

    it do
      should have_content('Администратор')
      should have_content('Имя: ' + user.name)
      should have_link('Edit', href: edit_user_path(user))
      should have_link('Back', href: users_path)
    end

    specify 'link Back' do
      click_link('Back')
      should have_content('Список администраторов')
    end

    specify 'link Edit' do
      click_link('Edit')
      should have_content('Editing User')
    end
  end

  describe 'edit user page (Список заказов)' do
  #--------------------------------------------------------------------
    before { visit edit_user_path(user) }

    it do
      should have_field('Имя', visible: user.name)
      should have_field('Пароль')
      should have_field('Подтверждение')
      should have_button('Update User')
      should have_link('Show', href: user_path(user))
      should have_link('Back', href: users_path)
    end

    specify 'button Update User' do
      click_button('Update User')
      should have_content('Список администраторов')
      should have_content('Сведения о пользователе ' + user.name + ' были успешно обновлены')
    end

    specify 'link Show' do
      click_link 'Show'
      should have_content('Администратор')
    end

    specify 'link Back' do
      click_link 'Back'
      should have_content('Список администраторов')
    end
  end
end