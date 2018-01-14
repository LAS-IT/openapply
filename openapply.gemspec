# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "openapply/version"

Gem::Specification.new do |spec|
  spec.name          = "openapply"
  spec.version       = Openapply::VERSION
  spec.authors       = ["Bill Tihen"]
  spec.email         = ["btihen@gmail.com"]

  spec.summary       = %q{Access OpenApply's API with Ruby}
  spec.description   = %q{Access to OpenApply's API and extra utilities that
                          accomplish common needs -- such as recursively query
                          for all students of a given status or change-date
                          until all needed records are recieved.}
  spec.homepage      = "https://github.com/btihen/openapply"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.15"
  spec.add_dependency "json" , "~> 2.1"
  spec.add_dependency "net-ssh", "~> 4.2"
  spec.add_dependency "net-scp", "~> 1.2"
  #
  # spec.add_development_dependency "simplecov", "~> 0.15"
  # spec.add_development_dependency 'coveralls', "~> 0.8"
  spec.add_development_dependency 'codacy-coverage', '~> 1.1'
  spec.add_development_dependency "webmock", "~> 3.2"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "pry", "~> 0.11"

end
