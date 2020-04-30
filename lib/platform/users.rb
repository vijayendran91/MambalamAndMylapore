require 'pry'
require 'bcrypt'
require './lib/services/user_service'

module Platform
  module Users
    include Platform::UserData
    include BCrypt
    include MamAndMyl::Services::UserService

    def check_user_sign_in(params)
      user = get_user_by_id(param[:id])
      password = Password.new(user[:password])
      user.to_json
    end

    #Create
    def user_signup(user_params)
      user = create_user(user_params)
      if user.save
        {:response => '200'}.to_json
      else
        user.errors.messages.to_json
      end
    end

    #Read
    def get_users
      users = get_all_users
      users = users.map {|user| UserSerialize.new(user)}.to_json
      users
    end
    
    #Update
    def user_update(user_id, params)
      update_user(user_id, params)
    end

    #delete
    def delete_user(user_id)
      destroy_user(user_id)
    end
  end
end
