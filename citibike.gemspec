lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "citibike/version"

Gem::Specification.new do |spec|
  spec.name = "citibike"
  spec.version = CitiBike::VERSION
  spec.authors = ["Bob Gardner"]
  spec.email = ["bob.hn.gardner@gmail.com"]
  spec.summary = "Personal Citi Bike stats reporter."
  spec.description = "Download your Citi Bike trip data."
  spec.homepage = "https://github.com/rgardner/citibike"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "highline", "~> 1.7"
  spec.add_runtime_dependency "htmlentities", "~> 4.3"
  spec.add_runtime_dependency "mechanize", "~> 2.7"
  spec.add_runtime_dependency "optimist", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
