module Fastlane
  module Actions
    class ScanAction < Action
      def self.run(values)
        require 'unity3d'

        begin
          FastlaneCore::UpdateChecker.start_looking_for_update('unity3d') unless Helper.is_test?

          Unity3d::Manager.new.work(values)

          true
        ensure
          FastlaneCore::UpdateChecker.show_update_status('unity3d', Unity3d::VERSION)
        end
      end

      def self.description
        "Easily export your unity3d app using `unity3d`"
      end

      def self.details
        "More information: https://github.com/fastlane/fastlane/tree/master/scan"
      end

      def self.author
        "Junhwan Oh"
      end

      def self.available_options
        require 'unity3d'
        Unity3d::Options.available_options
      end

      def self.is_supported?(platform)
        [:ios, :android].include? platform
      end
    end
  end
end
