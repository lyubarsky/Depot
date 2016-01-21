class User < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  after_destroy :ensure_an_admin_remain

  has_secure_password

  private

    def ensure_an_admin_remain
      if User.count == 0 #.zero?
        raise 'Последний администратор не может быть удален'
      end
    end
 end
