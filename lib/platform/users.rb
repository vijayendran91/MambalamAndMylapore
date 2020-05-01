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
      if user
        {:response => '200'}.to_json
      else
        raise MamAndMyl::Errors::InvalidUserDetailsError.new("Invalid user data")
      end
    end

    #Read
    def get_users
      begin
        users = get_all_users
        users = users.map {|user| UserSerialize.new(user)}.to_json
        data = users
      rescue MamAndMyl::Errors::InvalidUserDetailsError => e
        data = {:errors => {:message => e.message}}.to_json
      end
    end

    #Update
    def user_update(user_id, params)
      update_user(user_id, params)
    end

    #delete
    def delete_user(user_id)
      begin
        destroy_user(user_id)

      end
    end
  end
end
