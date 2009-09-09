require 'erb'
require 'yaml'
require 'ostruct'

erb = File.read(File.join(Rails.root, 'config', 'config.yml'))
yml = ERB.new(erb).result

# Load application config
config = YAML.load(yml)

# Remove Environment namespaces
config.delete('development')
config.delete('test')
config.delete('staging')
config.delete('production')

# Merge back in current environment
config.merge!(YAML.load(yml)[Rails.env]) if YAML.load(yml)[Rails.env].is_a?(Hash)

# Define true? style methods
truthy = {}
config.each do |key,value|
  truthy[key.to_s + "?"] = value if value.is_a?(TrueClass) || value.is_a?(FalseClass)
end
config.merge!(truthy)

# Convert all keys and sub keys to symbols
config.symbolize_keys!
config.each do |key, value|
  config[key].symbolize_keys! if value.kind_of?(Hash)
end

# Create NewsStand OpenStruct
::App = OpenStruct.new(config)