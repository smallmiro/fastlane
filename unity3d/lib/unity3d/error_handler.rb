# coding: utf-8
module Unity3d
  
  class ErrorHandler
    class << self
      def handle_build_error(output)
        print output
        UI.user_error!("Error building the application - see the log above")
      end

      # Just to make things easier
      def print(text)
        UI.error text
      end
    end
  end
end
