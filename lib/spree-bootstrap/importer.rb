require 'sass'
module Sass
  module Importers
    class Custom < Base
      def find(name, options)
        if name == '[globals]'
          options[:syntax] = :scss
          options[:filename] = 'globals'
          options[:importer] = self
          return Sass::Engine.new("$imported-variable:#{SpreeTheme['mainColor']}", options)
        else
          return nil
        end
      end

      def find_relative(uri, base, options)
        nil
      end

      def key(uri, options)
        [self.class.name + ":" + uri, uri]
      end

      def mtime(uri, options)
        nil
      end

      def to_s
        '[custom]'
      end
    end
  end
end