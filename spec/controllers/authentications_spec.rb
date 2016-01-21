require 'spec_helper'

describe 'Authentication' do
  let(:user) { FactoryGirl.create(:user) }

  describe 'attempting to administrative pages by non logged user' do

    describe UsersController do

      let(:valid_attributes) { { name: 'another_name', password: 'my_password',
                                 password_confirmation: 'my_password' } }

      it ' get :index will redirect to login' do
        get :index
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :show will redirect to login' do
        get :show, { id: user.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :new will redirect to login' do
        get :new
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :edit will redirect to login' do
        get :edit, { id: user.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'post :create will redirect to login' do
        post :create, { user: valid_attributes }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'put :update will redirect to login' do
        another_user = User.create! valid_attributes
        put :update, { id: another_user.to_param, user: valid_attributes }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'delete :destroy will redirect to login' do
        another_user = User.create! valid_attributes
        delete :destroy, {id: another_user.to_param}
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end
    end
# ----------------------------------------------------------------
    describe ProductsController do
      let(:valid_attributes) { {  title: 'another_title', description: 'my_description',
                                  image_url: 'my_image_url.jpg', price: 10 } }

      it 'get :index will redirect to login' do
        get :index
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :show will redirect to login' do
        product = Product.create! valid_attributes
        get :show, { id: product.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :new will redirect to login' do
        get :new
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :edit will redirect to login' do
        product = Product.create! valid_attributes
        get :edit, { id: product.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'post :create will redirect to login' do
        post :create, { product: valid_attributes }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'put :update will redirect to login' do
        product = Product.create! valid_attributes
        put :update, { id: product.to_param, product: valid_attributes }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'delete :destroy will redirect to login' do
        product = Product.create! valid_attributes
        delete :destroy, {id: product.to_param}
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end
    end
#--------------------------------------------------------------
    describe OrdersController do
      let(:valid_attributes) { {  name: 'my_name', address: 'my_address',
                                  email: 'my_email', pay_type: 'Check' } }

      it 'get :index will redirect to login' do
        get :index
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :show will redirect to login' do
        order = Order.create! valid_attributes
        get :show, { id: order.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :edit will redirect to login' do
        order = Order.create! valid_attributes
        get :edit, { id: order.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'put :update will redirect to login' do
        order = Order.create! valid_attributes
        put :update, { id: order.to_param, order: valid_attributes }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'delete :destroy will redirect to login' do
        order = Order.create! valid_attributes
        delete :destroy, {id: order.to_param}
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end
    end
# -----------------------------------------------------------------------
    describe LineItemsController do
      let(:valid_attributes) { {  product_id: 1, cart_id: 1, order_id: 1, quantity: 1 } }

      it 'get :index will redirect to login' do
        get :index
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :show will redirect to login' do
        line_item = LineItem.create! valid_attributes
        get :show, { id: line_item.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :new will redirect to login' do
        get :new
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :edit will redirect to login' do
        line_item = LineItem.create! valid_attributes
        get :edit, { id: line_item.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'put :update will redirect to login' do
        line_item = LineItem.create! valid_attributes
        put :update, { id: line_item.to_param, line_item: valid_attributes }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end
    end
# ------------------------------------------------------------
    describe CartsController do
      let(:cart) {FactoryGirl.create(:curt) }

      it 'get :index will redirect to login' do
        get :index
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :show will redirect to login' do
        cart = Cart.create!
        get :show, { id: cart.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :new will redirect to login' do
        get :new
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end

      it 'get :edit will redirect to login' do
        cart = Cart.create!
        get :edit, { id: cart.to_param }
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end
    end
# ------------------------------------------------------------------
    describe AdminController do
      it 'get :index will redirect to login' do
        get :index
        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'Пожалуйста, пройдите авторизацию'
      end
    end
  end
# =================================================================

  describe 'attempting to administrative pages by logged user' do
    let(:valid_session) { { user_id: user.id } }

    describe UsersController do

      let(:valid_attributes) { { name: 'another_name', password: 'my_password',
                                 password_confirmation: 'my_password' } }

      it 'get :index will give a successful request' do
        get :index, {}, valid_session
        expect(response).to be_success
      end

      it 'get :show will give a successful request' do
        get :show, { id: user.to_param }, valid_session
        expect(response).to be_success
        end

      it 'get :new will give a successful request' do
        get :new, {}, valid_session
        expect(response).to be_success
      end

      it 'get :edit will give a successful request' do
        get :edit, { id: user.to_param }, valid_session
        expect(response).to be_success
      end

      it 'post :create redirects to the users' do
        post :create, { user: valid_attributes }, valid_session
        expect(response).to redirect_to('/users')
        expect(flash[:notice]).to eq 'Пользователь another_name был успешно создан'
      end

      it 'put :update redirects to the users' do
        another_user = User.create! valid_attributes
        put :update, { id: another_user.to_param, user: valid_attributes },
            valid_session
        expect(response).to redirect_to('/users')
        expect(flash[:notice]).to eq 'Сведения о пользователе another_name были успешно обновлены'
      end

      it 'delete :destroy redirects to the users' do
        another_user = User.create! valid_attributes
        delete :destroy, {id: another_user.to_param}, valid_session
        expect(response).to redirect_to('/users')
        expect(flash[:notice]).to eq 'Администратор another_name удален'
      end
    end
# -----------------------------------------------------------------
    describe ProductsController do

      let(:valid_attributes) { {  title: 'another_title', description: 'my_description',
                                image_url: 'my_image_url.jpg', price: 10 } }

      it 'get :index will give a successful request' do
        get :index, {}, valid_session
        expect(response).to be_success
      end

      it 'get :show will give a successful request' do
        product = Product.create! valid_attributes
        get :show, { id: product.to_param }, valid_session
        expect(response).to be_success
      end

      it 'get :new will give a successful request' do
        get :new, {}, valid_session
        expect(response).to be_success
      end

      it 'get :edit will give a successful request' do
        product = Product.create! valid_attributes
        get :edit, { id: product.to_param }, valid_session
        expect(response).to be_success
      end

      it 'post :create redirects to the products(1)' do
        post :create, { product: valid_attributes }, valid_session
        expect(response).to redirect_to('/products/1')
        expect(flash[:notice]).to eq 'Товар успешно создан'
      end

      it 'put :update redirects to the products (1)' do
        product = Product.create! valid_attributes
        put :update, { id: product.to_param, product: valid_attributes },
            valid_session
        expect(response).to redirect_to('/products/1')
        expect(flash[:notice]).to eq 'Товар успешно обновлен'
      end

      it 'delete :destroy redirects to the products' do
        product = Product.create! valid_attributes
        delete :destroy, {id: product.to_param}, valid_session
        expect(response).to redirect_to('/products')
        expect(flash[:notice]).to eq 'Товар успешно удален'
      end
    end
#--------------------------------------------------------------
    describe OrdersController do
      let(:valid_attributes) { {  name: 'my_name', address: 'my_address',
                                  email: 'my_email', pay_type: 'Check' } }

      it 'get :index will give a successful request' do
        get :index, {}, valid_session
        expect(response).to be_success
      end

      it 'get :show will give a successful request' do
        order = Order.create! valid_attributes
        get :show, { id: order.to_param }, valid_session
        expect(response).to be_success
      end

      it 'get :edit will give a successful request' do
        order = Order.create! valid_attributes
        get :edit, { id: order.to_param }, valid_session
        expect(response).to be_success
      end

      it 'put :update redirects to the orders (1)' do
        order = Order.create! valid_attributes
        put :update, { id: order.to_param, order: valid_attributes },
            valid_session
        expect(response).to redirect_to('/orders/1')
        expect(flash[:notice]).to eq 'Заказ успешно обновлен'
      end

      it 'delete :destroy redirects to the products' do
        order = Order.create! valid_attributes
        delete :destroy, {id: order.to_param}, valid_session
        expect(response).to redirect_to('/orders')
        expect(flash[:notice]).to eq 'Заказ успешно уничтожен'
      end
    end
    # -----------------------------------------------------------------------
    describe LineItemsController do
      let(:valid_attributes) { {  product_id: 1, cart_id: 1, order_id: 1, quantity: 1 } }

      it ' get :index will give a successful request' do
        get :index, {}, valid_session
        expect(response).to be_success
      end

      it 'get :show will give a successful request' do
        line_item = LineItem.create! valid_attributes
        get :show, { id: line_item.to_param }, valid_session
        expect(response).to be_success
      end

      it 'get :new will give a successful request' do
        get :new, {}, valid_session
        expect(response).to be_success
      end

      it 'get :edit will give a successful request' do
        line_item = LineItem.create! valid_attributes
        get :edit, { id: line_item.to_param }, valid_session
        expect(response).to be_success
      end

      it ' put :update redirects to the line_items(1)' do
        line_item = LineItem.create! valid_attributes
        put :update, { id: line_item.to_param, line_item: valid_attributes },
            valid_session
        expect(response).to redirect_to('/line_items/1')
        expect(flash[:notice]).to eq 'Товарная запись была успешно оновлена'
      end
    end
# ------------------------------------------------------------
    describe CartsController do

      it 'get :index will give a successful request' do
        get :index, {}, valid_session
        expect(response).to be_success
      end

      it 'get :show will give a successful request' do
        cart = Cart.create!
        get :show, { id: cart.to_param }, valid_session
        expect(response).to be_success
      end

      it 'get :new will give a successful request' do
        get :new, {}, valid_session
        expect(response).to be_success
      end

      it 'get :edit will give a successful request' do
        cart = Cart.create!
        get :edit, { id: cart.to_param }, valid_session
        expect(response).to be_success
      end
    end
# ------------------------------------------------------------------
    describe AdminController do
      it 'get :index will give a successful request' do
        get :index, {}, valid_session
        expect(response).to be_success
      end
    end
  end
end







