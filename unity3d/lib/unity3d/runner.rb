require 'pty'
require 'open3'
require 'fileutils'
require 'shellwords'

require 'file/tail'

module Unity3d
  class Runner
    # @return (String) The path to the resulting ipa
    def run
      
      print_command(command, "Export " + Unity3d.config[:buildTarget]) if $verbose

      UI.important BuildCommandGenerator.unity3d_log_path
      #if !Unity3d.config[:silent]
        logThread = Thread.new do # Here we start a new thread
          File.open(BuildCommandGenerator.unity3d_log_path) do |log|
            log.extend(File::Tail)
            log.interval = 1
            log.backward(0)
            log.tail { |line|
              if line.include? "WARNING"
                UI.important line.delete!("\n") 
              else 
                UI.message line.delete!("\n")    
              end 
              }
          end
          return nil
        end 
      #end 
      build_app
      #logThread.exit

    end

    #####################################################
    # @!group Printing out things
    #####################################################

    # @param [Array] An array containing all the parts of the command
    def print_command(command, title)
      rows = command.map do |c|
        current = c.to_s.dup
        next unless current.length > 0

        match_default_parameter = current.match(/(-.*) '(.*)'/)
        if match_default_parameter
          # That's a default parameter, like `-project 'Name'`
          match_default_parameter[1, 2]
        else
          current.gsub!("| ", "\| ") # as the | will somehow break the terminal table
          [current, ""]
        end
      end

      puts Terminal::Table.new(
        title: title.green,
        headings: ["Option", "Value"],
        rows: rows.delete_if { |c| c.to_s.empty? }
      )
    end

    private

    #####################################################
    # @!group The individual steps
    #####################################################

    # Builds the app and prepares the archive
    def build_app
      command = BuildCommandGenerator.generate
      print_command(command, "Generated Build Command") if $verbose
      FastlaneCore::CommandExecutor.execute(command: command,
                                          print_all: true,
                                      print_command: !Unity3d.config[:silent],
                                              error: proc do |output|
                                                ErrorHandler.handle_build_error(output)
                                              end)


      UI.success "Successfully stored the archive."
      #UI.verbose("Stored the archive in: " + BuildCommandGenerator.archive_path)
    end

  end
end
