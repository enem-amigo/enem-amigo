class User < ActiveRecord::Base
      before_save {     self.email  =     email.downcase    }
      has_secure_password
      VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :name, presence: true, length:{maximum: 60}
      validates :users_name, presence: true, length:{maximum: 40}, uniqueness: true
      validates :email, presence: true, length:{maximum: 255},
      format: { with: valid_email },
      uniqueness:{ case_sensitive: false}
      validates :password, length:{minimum: 8}
end