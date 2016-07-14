require 'unity3d/version'
require 'unity3d/manager'
require 'unity3d/options'
require 'unity3d/detect_values'
require 'unity3d/runner'
require 'Unity3d/error_handler'
require 'unity3d/generators/build_command_generator'

require 'fastlane_core'
require 'terminal-table'
require 'shellwords'

module Unity3d
  class << self
    attr_accessor :config

    attr_accessor :project

    attr_accessor :cache

    def config=(value)
      @config = value
      DetectValues.set_additional_default_values
      @cache = {}
    end

    def unity3dfile_name
      "Unity3dfile"
    end

    def init_libs
      # Import all the fixes
    end
  end

  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI

  Unity3d.init_libs
end
