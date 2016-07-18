require "fastlane_core"

module Unity3d
  class Options
    def self.available_options
      [ 
        FastlaneCore::ConfigItem.new(key: :buildTarget,
                                     short_option: "-b",
                                     optional: false,
                                     env_name: "UNITY3D_BUILD_TARGET",
                                     description: "Allows the selection of an active build target before a project is loaded Possible options are: win32, win64, osx, linux, linux64, ios, android, web, webstreamed, webgl, xbox360, xboxone, ps3, ps4, psp2, wsa, wp8, tizen, samsungtv"),
        FastlaneCore::ConfigItem.new(key: :project,
                                     short_option: "-w",
                                     env_name: "UNITY3D_PROJECT_PATH",
                                     description: "Open the project at the given path",
                                     verify_block: proc do |value|
                                        v = File.expand_path(value.to_s)
                                        UI.user_error!("Project Path not found at path '#{v}'") unless File.exist?(v)
                                     end),              
        FastlaneCore::ConfigItem.new(key: :unityPath,
                                     env_name: "UNITY3D_APP_PATH",
                                     optional: true,
                                     default_value: "/Applications/Unity/Unity.app",
                                     description: "Install path of Unity3d",
                                     verify_block: proc do |value|
                                        v = File.expand_path(value.to_s)
                                        UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                     end),     
        FastlaneCore::ConfigItem.new(key: :logFile ,
                                     short_option: "-l",
                                     optional: true,
                                     env_name: "UNITY3D_LOGFILE",
                                     description: "Specify where the Editor or Windows/Linux/OSX standalone log file will be written"), 
        FastlaneCore::ConfigItem.new(key: :nographics ,
                                     optional: true,
                                     env_name: "UNITY3D_NOGRAPHICS",
                                     description: "When running in batch mode, do not initialize graphics device at all"),         
        FastlaneCore::ConfigItem.new(key: :serial ,
                                     short_option: "-s",
                                     optional: true,
                                     env_name: "UNITY3D_ACTIVATES_SERIAL",
                                     description: "Activates Unity with the specified serial key"),   
        FastlaneCore::ConfigItem.new(key: :username ,
                                     short_option: "-u",
                                     optional: true,
                                     env_name: "UNITY3D_USERNAME",
                                     description: "The username of the user - needed when activating\. This option is new in Unity 5\.1"),     
        FastlaneCore::ConfigItem.new(key: :password ,
                                     short_option: "-p",
                                     optional: true,
                                     env_name: "UNITY3D_PASSWORD",
                                     description: "The password of the user - needed when activating\. This option is new in Unity 5\.1"),                                                                                  
        # Very optional
        FastlaneCore::ConfigItem.new(key: :assetServerUpdate ,
                                      optional: true,
                                      env_name: "UNITY3D_ASSET_SERVER_UPDATE",
                                      description: "Force an update of the project in the Asset Server given by IP:port"),
        FastlaneCore::ConfigItem.new(key: :buildLinux32Player ,
                                    env_name: "UNITY3D_BUILD_LINUX32_PLAYER",
                                    description: "Build a 32-bit standalone Linux player (eg -buildLinux32Player path/to/your/build)",
                                    optional: true,
                                    verify_block: proc do |value|
                                      v = File.expand_path(value.to_s)
                                      UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                    end),
        FastlaneCore::ConfigItem.new(key: :buildLinux64Player ,
                                    env_name: "UNITY3D_BUILD_LINUX64_PLAYER",
                                    description: "Build a 64-bit standalone Linux player (eg -buildLinux32Player path/to/your/build)",
                                    optional: true,
                                    verify_block: proc do |value|
                                      v = File.expand_path(value.to_s)
                                      UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                    end),
        FastlaneCore::ConfigItem.new(key: :buildLinuxUniversalPlayer  ,
                                    env_name: "UNITY3D_BUILD_UNIVERSAL_PLAYER",
                                    description: "Build a combined 32-bit and 64-bit standalone Linux player (eg -buildLinuxUniversalPlayer path/to/your/build)",
                                    optional: true,
                                    verify_block: proc do |value|
                                      v = File.expand_path(value.to_s)
                                      UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                    end),
        FastlaneCore::ConfigItem.new(key: :buildOSXPlayer   ,
                                    env_name: "UNITY3D_BUILD_OSX_PLAYER",
                                    description: "Build a 32-bit standalone Mac OSX player (eg -buildOSXPlayer path/to/your/build.app)",
                                    optional: true,
                                    verify_block: proc do |value|
                                      v = File.expand_path(value.to_s)
                                      UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                    end),
        FastlaneCore::ConfigItem.new(key: :buildOSX64Player    ,
                                    env_name: "UNITY3D_BUILD_OSX64_PLAYER",
                                    description: "Build a 64-bit standalone Mac OSX player (eg -buildOSX64Player path/to/your/build.app)",
                                    optional: true,
                                    verify_block: proc do |value|
                                      v = File.expand_path(value.to_s)
                                      UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                    end),
        FastlaneCore::ConfigItem.new(key: :buildOSXUniversalPlayer     ,
                                    env_name: "UNITY3D_BUILD_OSXUNIVERSAL_PLAYER",
                                    description: "Build a combined 32-bit and 64-bit standalone Mac OSX player (eg -buildOSXUniversalPlayer path/to/your/build.app)",
                                    optional: true,
                                    verify_block: proc do |value|
                                      v = File.expand_path(value.to_s)
                                      UI.user_error!("Player Path not found at path '#{v}'") unless File.exist?(v)
                                    end),               
        FastlaneCore::ConfigItem.new(key: :buildWebPlayer ,
                                     env_name: "UNITY3D_BUILD_WEB_PLAYER",
                                     optional: true,
                                     description: "Build a WebPlayer (e\.g\. -buildWebPlayer path/to/your/build)",
                                     verify_block: proc do |value|
                                        v = File.expand_path(value.to_s)
                                        UI.user_error!("WebPlayer Path not found at path '#{v}'") unless File.exist?(v)
                                     end),            
        FastlaneCore::ConfigItem.new(key: :buildWebPlayerStreamed  ,
                                     env_name: "UNITY3D_BUILD_WEB_PLAYER_STREAMED",
                                     optional: true,
                                     description: "Build a Streamed WebPlayer (e\.g\. -buildWebPlayerStreamed path/to/your/build)",
                                     verify_block: proc do |value|
                                        v = File.expand_path(value.to_s)
                                        UI.user_error!("Streamed webPlayer Path not found at path '#{v}'") unless File.exist?(v)
                                     end),           
        FastlaneCore::ConfigItem.new(key: :buildWindowsPlayer   ,
                                     env_name: "UNITY3D_BUILD_WINDOWS_PLAYER",
                                     optional: true,
                                     description: "Build a 32-bit standalone Windows player (e\.g\. -buildWindowsPlayer path/to/your/build.exe)",
                                     verify_block: proc do |value|
                                        v = File.expand_path(value.to_s)
                                        UI.user_error!("Windows player Path not found at path '#{v}'") unless File.exist?(v)
                                     end),           
        FastlaneCore::ConfigItem.new(key: :buildWindows64Player    ,
                                     env_name: "UNITY3D_BUILD_WINDOWS_64PLAYER",
                                     optional: true,
                                     description: "Build a 64-bit standalone Windows player (e\.g\. -buildWindowsPlayer path/to/your/build.exe)",
                                     verify_block: proc do |value|
                                        v = File.expand_path(value.to_s)
                                        UI.user_error!("Windows 64bit player Path not found at path '#{v}'") unless File.exist?(v)
                                     end),     

       
        FastlaneCore::ConfigItem.new(key: :forceFree,
                                     env_name: "UNITY3D_FORCE_FRES",
                                     optional: true,
                                     description: "Make the editor run as if there is a free Unity license on the machine, even if a Unity Pro license is installed\."),           
        FastlaneCore::ConfigItem.new(key: :returnlicense    ,
                                     env_name: "UNITY3D_RETURNLICENSE",
                                     optional: true,
                                     description: "Return the currently active license to the license server\. Please allow a few seconds before license file is removed, as Unity needs to communicate with the license server\. This option is new in Unity 5\.0\.",),    
        # fastlane optional
        FastlaneCore::ConfigItem.new(key: :silent,
                                     short_option: "-a",
                                     env_name: "UNITY3D_SILENT",
                                     description: "Hide all information that's not necessary while building",
                                     default_value: false,
                                     is_string: false),

      ]
    end
  end
end
