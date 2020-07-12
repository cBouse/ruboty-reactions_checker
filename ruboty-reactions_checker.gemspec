require_relative 'lib/ruboty/reactions_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-reactions_checker"
  spec.version       = Ruboty::ReactionsChecker::VERSION
  spec.authors       = ["cBouse"]
  spec.email         = ["tyokoreito_oisiiyo@yahoo.co.jp"]
  
  spec.summary       = "Ruboty handler to mention members who is not reacting"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/cBouse/ruboty-reactions_checker"
  spec.license       = "MIT"
  
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.metadata["homepage_uri"] = spec.homepage
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'ruboty'
  spec.add_dependency 'slack-api'
  
  spec.add_development_dependency 'bundle'
  spec.add_development_dependency 'rake'
end
