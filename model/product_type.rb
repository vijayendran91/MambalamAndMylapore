require 'mongoid'

module Platform
  module Product
    class ProductType
      include Mongoid::Document

      field :type, :type => String
      field :som, :type => String

      validates :type, :presence => true
      validates :som, :presence=>true

    end

    class ProductTypeSerialize
      def initialize(product_type)
        @product_type = product_type
      end

      def as_json(*)
        data = {}
        data[:id] = @product_type.id.to_s
        data[:type] = @product_type.type.to_s
        data[:state_of_matter] = @product_type.som.to_s
        data[:error] = @product_type.errors if @product_type.errors.any?
        data
      end
    end
  end
end
