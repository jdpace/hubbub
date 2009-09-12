# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

begin
  require 'vlad'
  Vlad.load :scm => :git, :app => :passenger
rescue LoadError
  puts 'Vlad is not installed on this system. You will need to install vlad and vlad-git before deploying Hubbub.'
end

