require 'rails/generators/base'

module Rcqrs
  module Generators
    class InstallGenerator < Rails::Generators::Base
    
      def add_gem_dependencies
        gem "uuidtools"
        gem "yajl-ruby", :require => 'yajl'
        gem "eventful"
        gem "rcqrs", :git => "git://github.com/virtualstaticvoid/rcqrs.git", :branch => "master"
        gem "rcqrs-rails", :git => "git://github.com/virtualstaticvoid/rcqrs-rails.git", :branch => "master"
      end

      def create_event_storage_db_config_file
        # just copy the existing one :-P
        copy_file File.join(destination_root, "config/database.yml"), "config/event_storage.yml"
      end

      def create_rcqrs_publish_initializer
        @snippet = <<CODE
# define "global" publish method
def publish(command)
  Rcqrs::Gateway.publish(command)
end
CODE

        initializer 'rcqrs_publish.rb', @snippet
      end

      def create_rcqrs_directories
        empty_directory_with_gitkeep "app/commands"
        empty_directory_with_gitkeep "app/commands/handlers"
        empty_directory_with_gitkeep "app/domain"
        empty_directory_with_gitkeep "app/events"
        empty_directory_with_gitkeep "app/events/handlers"
      end
    
      def create_rcqrs_autoload_paths_initializer
        @snippet = <<CODE
# include command, events, handlers and domain classes in the application auto load paths
ActiveSupport::Dependencies.autoload_paths += %W(
  #\{Rails.root.to_s\}/app/commands
  #\{Rails.root.to_s\}/app/commands/handlers
  #\{Rails.root.to_s\}/app/domain
  #\{Rails.root.to_s\}/app/events
  #\{Rails.root.to_s\}/app/events/handlers
)
CODE

        initializer 'rcqrs_autoload_paths.rb', @snippet
      end

      private

      def empty_directory_with_gitkeep(destination, config = {})
        empty_directory(destination, config)
        create_file("#{destination}/.gitkeep") unless options[:skip_git]
      end 

    end
  end
end

