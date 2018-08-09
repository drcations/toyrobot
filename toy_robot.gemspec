lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
    spec.name          = "toy_robot"
    spec.version       = '0.0.1'
    spec.authors       = ["Dave C"]
  
    spec.summary       = %q{Toy Robot}
    spec.description   = %q{Domo Arigato Mr.Roboto}
