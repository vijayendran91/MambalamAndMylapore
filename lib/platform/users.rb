require 'pry'
require 'bcrypt'
require './lib/services/user_service'
require './lib/platform/utils'


module MamAndMyl
  module Platform
    module Users
      include MamAndMyl::Platform::UserData
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

      def get_user_by_id param
        begin
          id = BSON::ObjectId(param[:id])
          data = get_user_with_id param
          raise MamAndMyl::Errors::UserNotFoundError.new("User not found") if data.user.empty?
        rescue MamAndMyl::Errors::UserNotFoundError => e
          {:errors => {:message => e.message}}
        rescue BSON::ObjectId::Invalid => e
          {:errors => {:message => e.message}}
        end
      end

      def get_user_by_email param
        begin
          MamAndMyl::Platform::Utils.is_a_valid_email(param[:email_id])
          data = get_user_with_email param
          raise MamAndMyl::Errors::UserNotFoundError.new("User not found") if data.user.empty?
        rescue MamAndMyl::Errors::UserNotFoundError => e
          {:errors => {:message => e.message}}
        end
      end

      def get_user_by_username param
        begin
          data = get_user_with_username param
          raise MamAndMyl::Errors::UserNotFoundError.new("User not found") if data.user.empty?
        rescue MamAndMyl::Errors::UserNotFoundError => e
          {:errors => {:message => e.message}}
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
end
