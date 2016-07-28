require 'shellwords'

module Unity3d
  # Responsible for building the fully working xcodebuild command
  class BuildCommandGenerator
    class << self
      def generate
        config = Unity3d.config
        parts = prefix
        parts << "#{config[:unityPath]}/Contents/MacOS/Unity"
        parts += options
        parts += pipe

        parts
      end

      def prefix
        ["set -o pipefail &&"]
      end

      def options
        config = Unity3d.config

        options = []
        options << "-batchmode "
        options << "-quit "
        options << "-cleanedLogFile"
        options << "-serial '#{config[:serial]}'" if config[:serial]
        options << "-nographics" if config[:nographics]
        options << "-projectPath '#{config[:project]}'" if config[:project]
        options << "-buildTarget '#{config[:buildTarget]}'" if config[:buildTarget]
        options << "-executeMethod '#{config[:executeMethod]}'" if config[:executeMethod]
        options << "-logFile '#{config[:project]}/#{config[:logFile]}'" if config[:logFile]

        #Very optional
        options << "-assetServerUpdate '#{config[:assetServerUpdate]}'" if config[:assetServerUpdate]
        options << "-buildLinux32Player '#{config[:buildLinux32Player]}'" if config[:buildLinux32Player]
        options << "-buildLinux64Player '#{config[:buildLinux64Player]}'" if config[:buildLinux64Player]
        options << "-buildLinuxUniversalPlayer '#{config[:buildLinuxUniversalPlayer]}'" if config[:buildLinuxUniversalPlayer]
        options << "-buildOSXPlayer '#{config[:buildOSXPlayer]}'" if config[:buildOSXPlayer]
        options << "-buildOSX64Player '#{config[:buildOSX64Player]}'" if config[:buildOSX64Player]
        options << "-buildOSXUniversalPlayer '#{config[:buildOSXUniversalPlayer]}'" if config[:buildOSXUniversalPlayer]
        options << "-buildWebPlayer '#{config[:buildWebPlayer]}'" if config[:buildWebPlayer]
        options << "-buildWebPlayerStreamed '#{config[:buildWebPlayerStreamed]}'" if config[:buildWebPlayerStreamed]
        options << "-buildWindowsPlayer '#{config[:buildWindowsPlayer]}'" if config[:buildWindowsPlayer]
        options << "-buildWindows64Player '#{config[:buildWindows64Player]}'" if config[:buildWindows64Player]
      

        options << "-force-free" if config[:forceFree]
        options << "-returnlicense" if config[:returnlicense]
        options << "#{config[:customBuildParam]}" if config[:customBuildParam]
        
        options
      end


      def pipe

        pipe = []
        pipe << " > /dev/null" 

        pipe
      end

      def unity3d_log_path
        file_name = "#{Unity3d.config[:logFile]}"
        containing = File.expand_path(Unity3d.config[:project])
        FileUtils.mkdir_p(containing)

        return File.join(containing, file_name)
      end

    end
  end
end
