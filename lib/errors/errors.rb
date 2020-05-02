
module MamAndMyl
  module Errors

    class InvalidUserDetailsError < Exception
      @message = "Unexpected error occured"
      def self.initialize(msg)
        @message = msg
      end
    end

    class UserNotFoundError < Exception
      @message = "Unexpected error occured"
      def self.initialize(msg)
        @message = msg
      end
    end

  end
end
