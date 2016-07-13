module Unity3d
  class Manager
    def work(options)
      Unity3d.config = options

      FastlaneCore::PrintTable.print_values(config: Unity3d.config,
                                         hide_keys: [],
                                             title: "Summary for Unity3d #{Unity3d::VERSION}")

      return Runner.new.run
    end
  end
end
