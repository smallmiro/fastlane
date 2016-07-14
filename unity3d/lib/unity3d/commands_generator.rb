require "commander"
require "fastlane_core"


HighLine.track_eof = false

module Unity3d
  class CommandsGenerator
    include Commander::Methods
    UI = FastlaneCore::UI

    FastlaneCore::CommanderGenerator.new.generate(Unity3d::Options.available_options)

    def self.start
      FastlaneCore::UpdateChecker.start_looking_for_update("unity3d")
      new.run
    ensure
      FastlaneCore::UpdateChecker.show_update_status("unity3d", Unity3d::VERSION)
    end

    def convert_options(options)
      o = options.__hash__.dup
      o.delete(:verbose)
      o
    end

    def run
      program :version, Unity3d::VERSION
      program :description, Unity3d::DESCRIPTION
      program :help, "Author", "Junhwan Oh <junhwan.oh@nhnent.com>"
      program :help, "Website", "https://fastlane.tools"
      program :help, "GitHub", "https://github.com/smallmiro/fastlane/tree/master/unity3d"
      program :help_formatter, :compact

      global_option("--verbose") { $verbose = true }

      command :build do |c|
        c.syntax = "unity3d"
        c.description = "Just export or build your unity3d app"
        c.action do |_args, options|
          config = FastlaneCore::Configuration.create(Unity3d::Options.available_options,
                                                      convert_options(options))
          Unity3d::Manager.new.work(config)
        end
      end

      command :init do |c|
        c.syntax = "unity3d init"
        c.description = "Creates a new Unity3dfile for you"
        c.action do |_args, options|
          containing = (File.directory?("fastlane") ? 'fastlane' : '.')
          path = File.join(containing, Unity3d.unity3dfile_name)
          UI.user_error! "Unity3dfile already exists" if File.exist?(path)
          template = File.read("#{Helper.gem_path('unity3d')}lib/assets/Unity3dfileTemplate")
          File.write(path, template)
          UI.success "Successfully created '#{path}'. Open the file using a code editor."
        end
      end

      default_command :build

      run!
    end
  end
end
