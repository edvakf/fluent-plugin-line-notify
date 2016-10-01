# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-line-notify"
  spec.version       = "0.1.0"
  spec.authors       = ["Atsushi Takayama"]
  spec.email         = ["taka.atsushi@gmail.com"]
  spec.summary       = %q{fluentd output plugin for LINE Notify}
  spec.description   = %q{fluent-plugin-line-notify is a fluentd plugin to call LINE Notify API.}
  spec.homepage      = "https://github.com/edvakf/fluent-plugin-line-notify"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", "~> 3.1.5"
  spec.add_development_dependency "test-unit-rr", "~> 1.0.5"

  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency "httparty"
end
