require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require './model/product_type'
require './model/user'
require 'pry'
require './lib/services/user_service'
require './lib/platform/users'
include Platform::Product
include Platform::UserData
include Platform::Users
Mongoid.load! 'mongoid.config'


class ApiApp < Sinatra::Base
  register Sinatra::Namespace
  namespace '/v1/api' do

    helpers do
      def json_params
        begin
          JSON.parse(request.body.read).with_indifferent_access
        rescue
          halt 400, {:message => "Invalid JSON"}.to_json
        end
      end

      def base_url
        @base_url ||= "#{env["rack.url_scheme"]}://#{env["HTTP_HOST"]}"
      end
    end

    post "/user/signup" do
      data = nil
      begin
        data = user_signup(json_params)
      rescue MamAndMyl::Errors::InvalidUserDetailsError => e
        data = {:errors => {:message => e.message}}.to_json
      end
      data
    end

    get "/users" do
      get_users
    end

    delete "/user" do
      user_id = json_params[:id]
      delete_user(user_id)
    end

    get "/signin/:id/password/:password" do
      check_user_sign_in(params)
    end

    put "/update/user/:id" do
      user_update(params[:id], json_params)
    end
  end

end
