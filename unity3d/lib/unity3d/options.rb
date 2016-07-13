require "fastlane_core"

module Unity3d
  class Options
    def self.available_options
      [
          FastlaneCore::ConfigItem.new(key: :scheme,
                                       short_option: "-s",
                                       optional: true,
                                       env_name: "GYM_SCHEME",
                                       description: "The project's scheme. Make sure it's marked as `Shared`")

      ]
    end
  end
end
