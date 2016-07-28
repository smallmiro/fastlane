module Fastlane
  module Actions
    module SharedValues
      UNITY3D_CUSTOM_VALUE = :UNITY3D_CUSTOM_VALUE
    end

    class Unity3dAction < Action
      def self.run(params)
        require 'unity3d'
        
          FastlaneCore::UpdateChecker.start_looking_for_update('unity3d') unless Helper.is_test?

          Unity3d::Manager.new.work(params)
      end

      def self.description
        "Easily build and export your Unity3d app "
      end

      def self.details
        "More information: https://github.com/smallmiro/fastlane/tree/master/unity3d"
      end

      def self.available_options
        require 'unity3d'
      	Unity3d::Options.available_options
      end

      def self.return_value
        "The absolute path to the generated apk file or iOS project"
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        "Junhwan Oh"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
