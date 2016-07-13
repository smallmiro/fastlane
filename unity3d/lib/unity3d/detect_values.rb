module Unity3d
  # This class detects all kinds of default values
  class DetectValues
    # This is needed as these are more complex default values
    # Returns the finished config object
    def self.set_additional_default_values
      config = Unity3d.config

      # First, try loading the Gymfile from the current directory
      config.load_configuration_file(Unity3d.unity3dfile_name)

      
      detect_configuration

      return config
    end

    # Detects the available configurations (e.g. Debug, Release)
    def self.detect_configuration
      config = Unity3d.config
      
    end
  end
end
