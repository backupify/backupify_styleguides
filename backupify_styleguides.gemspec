# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "backupify_styleguides"
  spec.version       = '0.0.1'
  spec.authors       = ["Josh Bodah"]
  spec.email         = ["jb3689@yahoo.com"]

  spec.summary       = %q{backupify_stylguides}
  spec.homepage      = "https://github.com/backupify/backupify_styleguides"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(config|test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rubocop', '~> 0.39'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
