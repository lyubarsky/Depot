FactoryGirl.define do

  factory :product do
    title       'product_title'
    description 'product_description'
    image_url   'product_image_url.jpg'
    price       10
  end

  factory :user do
    name                  'user_name'
    password              'user_password'
    password_confirmation 'user_password'
  end

  factory :order do
    name       'customer_name'
    address    'customer_address'
    email      'customer_email'
    pay_type   'Check'
  end

  factory :line_item do
    cart_id     1
    product_id  1
    order_id    1
    quantity    1
  end

  factory :cart do
  end
end