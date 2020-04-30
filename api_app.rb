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


    get "/product_type" do
      product_types=ProductType.all()
      product_types.map {|product_type| ProductTypeSerialize.new(product_type)}.to_json
    end

    post "/product_type" do
      product_type = ProductType.new(json_params)
      if product_type.save
        response.headers['Location']= "#{base_url}/product_type/#{product_type[:id]}"
        status 201
      else
        status 401
        body ProductTypeSerialize.new(product_type).to_json
      end
    end

    post "/user/signup" do
      user_signup(json_params)
    end

    get "/users" do
      get_users
    end

    delete "/all_users" do
      users = User.all
      users.each do |user|
        user.destroy
      end
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
