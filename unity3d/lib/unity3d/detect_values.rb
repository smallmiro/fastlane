module Unity3d
  # This class detects all kinds of default values
  class DetectValues
    # This is needed as these are more complex default values
    # Returns the finished config object
    def self.set_additional_default_values
      config = Unity3d.config

      # First, try loading the Gymfile from the current directory
      config.load_configuration_file(Unity3d.gymfile_name)

      # Detect the project
      FastlaneCore::Project.detect_projects(config)
      Unity3d.project = FastlaneCore::Project.new(config)
      detect_provisioning_profile

      # Go into the project's folder, as there might be a Gymfile there
      Dir.chdir(File.expand_path("..", Unity3d.project.path)) do
        config.load_configuration_file(Unity3d.gymfile_name)
      end

      config[:use_legacy_build_api] = true if Xcode.pre_7?

      detect_scheme
      detect_platform # we can only do that *after* we have the scheme
      detect_configuration

      config[:output_name] ||= Unity3d.project.app_name

      return config
    end

    # Is it an iOS device or a Mac?
    def self.detect_platform
      return if Unity3d.config[:destination]
      platform = if Unity3d.project.mac?
                   "OS X"
                 elsif Unity3d.project.tvos?
                   "tvOS"
                 else
                   "iOS"
                 end

      Unity3d.config[:destination] = "generic/platform=#{platform}"
    end

    # Detects the available configurations (e.g. Debug, Release)
    def self.detect_configuration
      config = Unity3d.config
      configurations = Unity3d.project.configurations
      return if configurations.count == 0 # this is an optional value anyway

      if config[:configuration]
        # Verify the configuration is available
        unless configurations.include?(config[:configuration])
          UI.error "Couldn't find specified configuration '#{config[:configuration]}'."
          config[:configuration] = nil
        end
      end
    end
  end
end
