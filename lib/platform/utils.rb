
module MamAndMyl
  module Platform
    class Utils

      def self.is_a_valid_email(email_str)
        email = (email_str.is_a? String) ? email_str : email_str.to_s
        regex = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
        result = regex.match(email).nil? ? false : true
        result
      end

    end
  end
end
