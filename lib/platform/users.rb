require '././model/user'
require 'pry'
require 'bcrypt'

module Platform
  module Users
    include Platform::UserData
    include BCrypt

    def get_all_users
      users = User.all
      users=users.map {|user| UserSerialize.new(user)}.to_json
      users
    end

    def check_user_sign_in(params)
      user = User.where(:id => params[:id]).first
      password = Password.new(user[:password])
      user.to_json
    end

    def get_user_with_username(username)
      user = User.where(:uname => username).first
      user
    end

    def user_signup(user_params)
      user = User.new(user_params)
      if user.save
        {:response => '200'}
      else
        user.errors.messages
      end
    end
  end
end
