# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "openapply/version"

Gem::Specification.new do |spec|
  spec.name          = "openapply"
  spec.version       = Openapply::Version::VERSION
  spec.authors       = ["Bill Tihen", "Elliott Hébert"]
  spec.email         = ["btihen@gmail.com","btihen@las.ch","ehebert@las.ch"]

  spec.summary       = %q{Access OpenApply's APIs with Ruby}
  spec.homepage      = "https://github.com/las-it/openapply"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.20"
  spec.add_dependency "json" , "~> 2.6"
  spec.add_dependency "oauth2", "~> 2.0"

  spec.add_development_dependency 'codacy-coverage', '~> 2.2'
  spec.add_development_dependency "webmock", "~> 3.18"
  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "pry", "~> 0.14"
end
