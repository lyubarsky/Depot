require 'spec_helper'

describe 'Products Pages' do
#==========================================================
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user}

  subject { page }

  describe 'products page (Список товаров)' do
  #--------------------------------------------------------
    let!(:product) { FactoryGirl.create(:product) }
    before { visit products_path }

    it do
      should have_content('Список товаров')
      should have_content(product.title)
      should have_content(product.description)
      should have_link('Show', href: product_path(product))
      should have_link('Edit', href: edit_product_path(product))
      should have_link('Destroy', href: product_path(product))
      should have_link('New Product', href: new_product_path)
    end

    specify 'link Show' do
      click_link 'Show'
      should have_content('Характеристики товара')
    end

    specify 'link Edit' do
      click_link 'Edit'
      should have_content('Editing Product')
    end

    specify 'link Destroy' do
      expect { click_link('Destroy') }.to change(Product, :count).by(-1)
      should have_content('Список товаров')
      should have_content('Товар успешно удален')
    end

    specify 'link New Product' do
      click_link 'New Product'
      should have_content('New Product')
    end

    describe 'New Product page' do
    #------------------------------------------------------
      before { visit new_product_path }

      it  do
        should have_content('New Product')
        should have_field('Title')
        should have_field('Description')
        should have_field('Image url')
        should have_field('Price')
        should have_button('Create Product')
        should have_link('Back', href: products_path)
      end

      specify 'button Create Product' do
        expect do
          fill_in 'Title', with: 'new_title'
          fill_in 'Description', with: 'new_description'
          fill_in 'Image url', with: 'new_image_url.gif'
          fill_in 'Price', with: 1
          click_button('Create Product')
        end.to change(Product, :count).by(1)

        should have_content('Товар успешно создан')
        should have_content('Title: new_title')
        should have_content('Description: new_description')
        should have_content('Image url: new_image_url.gif')
        should have_content('Price: 1.0')
      end

      specify 'link Back' do
        click_link('Back')
        should have_content('Список товаров')
      end
    end

    describe 'page Show' do
    #--------------------------------------------------------------------
      before { visit product_path(product) }

      it do
        should have_content('Title: ' + product.title)
        should have_content('Description: ' + product.description)
        should have_content('Image url: ' + product.image_url)
        should have_content('Price: ' + product.price.to_s)
        should have_link('Edit', href: edit_product_path(product))
        should have_link('Back', href: products_path)
      end
      specify 'link Back' do
        click_link('Back')
        should have_content('Список товаров')
      end

      specify 'link Edit' do
        click_link('Edit')
        should have_content('Editing Product')
      end
    end

    describe 'page Edit' do
    #------------------------------------------------------
      before { visit edit_product_path(product) }

      it do
        should have_content('Editing Product')
        should have_field('Title', visible: product.title)
        should have_field('Description', visible: product.description)
        should have_field('Image url', visible: product.image_url)
        should have_field('Price', visible: product.price)
        should have_button('Update Product')
        should have_link('Show', href: product_path(product))
        should have_link('Back', href: products_path)
      end

      specify 'button Update Product' do
        click_button('Update Product')
        should have_content('Характеристики товара')
        should have_content('Товар успешно обновлен')
      end

      specify 'link Show' do
        click_link 'Show'
        should have_content('Характеристики товара')
      end

      specify 'link Back' do
        click_link 'Back'
        should have_content('Список товаров')
      end
    end
  end
end