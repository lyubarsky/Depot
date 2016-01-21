require 'spec_helper'

describe OrderNotifier do

  let(:product) { FactoryGirl.create(:product) }
  let(:order) { FactoryGirl.create(:order) }
  let!(:line_item) { FactoryGirl.create(:line_item,
                                        order_id: order.id, product_id: product.id) }
  let(:mail) { OrderNotifier.received(order) }

  it 'renders the headers' do
    mail.subject.should eq('Подтверждение заказа в Pragmatic Store')
    mail.to.should eq(["#{order.email}"])
    mail.from.should eq(['lyubarsky@gmail.com'])
    mail[:from].value.should eq('Michael Lyubarsky <lyubarsky@gmail.com>')
  end

  it 'renders the body' do
    # Rails.logger.debug("#{mail.body.encoded} <----------------------------------<<< ")
    mail.body.encoded.should match("#{order.name}")
    mail.body.encoded.should match("<td>#{product.title}</td>")
  end
end

describe 'mailing with OrderNotifier' do
  let!(:product) { FactoryGirl.create(:product) }

  before do
    visit store_path
    click_button 'Добавить в корзину'
    click_button 'Заказать'
    fill_in 'Name', with: 'customer_name'
    fill_in 'Address', with: 'customer_address'
    fill_in 'Email', with: 'customer_email'
    select('Check', from: 'Pay type')
    click_button('Сделать заказ')
  end

  describe 'received' do

   let(:mail) { ActionMailer::Base.deliveries.last }

    it 'renders the headers' do
      mail.subject.should eq('Подтверждение заказа в Pragmatic Store')
      mail.to.should eq(['customer_email'])
      mail.from.should eq(['lyubarsky@gmail.com'])
      mail[:from].value.should eq('Michael Lyubarsky <lyubarsky@gmail.com>')
    end

    it 'renders the body' do
      # Rails.logger.debug("#{mail.body.encoded} <---------------------------------------<<< ")
      mail.body.encoded.should match('customer_name</h1>')
      mail.body.encoded.should match("<td>#{product.title}</td>")
    end
  end
end
