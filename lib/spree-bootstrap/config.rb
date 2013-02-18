require File.join(File.dirname(__FILE__), 'importer.rb')
require File.join(File.dirname(__FILE__), 'defaults.rb')
Sass.load_paths << Sass::Importers::Custom.new()