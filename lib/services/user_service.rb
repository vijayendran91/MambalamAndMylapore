require '././model/user'
require 'pry'
require './lib/errors/errors'

module MamAndMyl
  module Services
    module UserService

      def get_user_with_id(params)
        user = User.where(:id => params[:id]).first
        UserSerialize.new(user)
      end

      def get_user_with_username(params)
        user = User.where(:uname => params[:username]).first
        UserSerialize.new(user)
      end

      def get_user_with_email(params)
        user = User.where(:email => params[:email_id]).first
        UserSerialize.new(user)
      end

      def create_user(params)
        user = User.new(params)
        user.save
      end

      def get_all_users
        User.all
      end

      def update_user(user_id, params)
        user = User.where(:id => user_id).first
        user.update_attributes(params)
      end

      def destroy_user(user_id)
        user = get_user_by_id(user_id)
        binding.pry
        user.destroy
      end

    end
  end
end
