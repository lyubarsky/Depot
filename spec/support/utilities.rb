
def sign_in (user)
  page.set_rack_session(user_id: user.id)
end

def register(cart)
  page.set_rack_session(cart_id: cart.id)
end
