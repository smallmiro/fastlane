# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "unity3d/version"

Gem::Specification.new do |spec|
  spec.name          = "unity3d"
  spec.version       = Unity3d::VERSION
  spec.authors       = ["Junhwan Oh"]
  spec.email         = ["junhwan.oh@nhnent.com"]
  spec.summary       = Unity3d::DESCRIPTION
  spec.description   = Unity3d::DESCRIPTION
  spec.homepage      = "https://fastlane.tools"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.0.0"

  spec.files = Dir["lib/**/*"] + %w(bin/unity3d README.md LICENSE)

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'fastlane_core', '>= 0.43.3', '< 1.0.0' # all shared code and dependencies
  spec.add_dependency 'terminal-table' # print out build information
  spec.add_dependency 'rubyzip', '>= 1.1.7' # fix swift/ipa
  spec.add_dependency "file-tail", '~> 1.1.1'

  # Development only
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "fastlane", ">= 1.33.0" # yes, we use fastlane for testing
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop", '~> 0.38.0'
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2.3'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "yard", "~> 0.8.7.4"
  spec.add_development_dependency "webmock", "~> 1.19.0"
  spec.add_development_dependency "coveralls"
end
