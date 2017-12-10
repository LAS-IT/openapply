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
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/btihen/openapply"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "http://rubygems.org"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

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

  # # need this version of axlsx to match roo's rubyzip needs
  # # axlsx 2.1.0.pre uses rubyzip 1.1.7 - which has a security flaw
  # # using the newest version of rubyzip 1.2.1 or larger
  # # https://github.com/randym/axlsx/issues/501
  # gem 'axlsx', git: 'https://github.com/randym/axlsx',
  #              branch: 'master'
  # https://github.com/straydogstudio/axlsx_rails/issues/77
  # gem 'axlsx', git: 'https://github.com/randym/axlsx.git',
  #              ref: '776037c0fc799bb09da8c9ea47980bd3bf296874'
  # spec.add_dependency 'axlsx', "2.1.0.pre"
  # # https://github.com/randym/axlsx/issues/234
  # # spec.add_dependency 'zip-zip'
  #
  # # # Rubyzip before 1.2.1 has a directory traversal vulnerability: CVE-2017-5946
  # spec.add_dependency  'rubyzip', '1.2.1'
  # spec.add_dependency  'rubyzip', '>= 1.2.1'
  # don't use official release - use above
  # spec.add_dependency "axlsx", "2.1.0.pre"
  # spec.add_dependency "rubyzip", "~> 1.2"

  spec.add_development_dependency "simplecov", "~> 0.15"
  spec.add_development_dependency "webmock" , "~> 3.1"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "pry", "~> 0.11"
  # spec.add_development_dependency "roo", "~> 2.7"

end
