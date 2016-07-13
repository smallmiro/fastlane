require 'shellwords'

module Unity3d
  # Responsible for building the fully working xcodebuild command
  class BuildCommandGenerator
    class << self
      def generate
        parts = prefix
        parts << "/Applications/Unity/Unity.app/Contents/MacOS/Unity"
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
        
        options << "-serial '#{config[:serial]}'" if config[:serial]
        options << "-projectPath '#{config[:projectPath]}'" if config[:projectPath]
        options << "-buildTarget '#{config[:buildTarget]}'" if config[:buildTarget]
        options << "-executeMethod '#{config[:executeMethod]}'" if config[:executeMethod]
        options << "-logFile '#{config[:projectPath]}/#{config[:logFile]}'" if config[:logFile]
        #options << "-configuration '#{config[:configuration]}'" if config[:configuration]
        
        options
      end


      def pipe
        pipe = []
        pipe << " > /dev/null" 

        pipe
      end

      def unity3d_log_path
        file_name = "#{Unity3d.config[:logFile]}"
        containing = File.expand_path(Unity3d.config[:projectPath])
        FileUtils.mkdir_p(containing)

        return File.join(containing, file_name)
      end

    end
  end
end
