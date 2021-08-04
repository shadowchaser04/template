# Add the current directory to the path Thor uses to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

def remove_gem_file
  # remove old gem file and create new one
  remove_file "Gemfile"
end

remove_gem_file


def create_gemfile
  begin
    run "touch Gemfile"
    add_source 'https://rubygems.org'
    # git_source(:github) { |repo| "https://github.com/#{repo}.git" }

    # Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
    gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
    gem 'sqlite3', '~> 1.4'
    gem 'puma', '~> 5.0'
    gem 'sass-rails', '>= 6'
    gem 'webpacker', '~> 5.0'
    gem 'turbolinks', '~> 5'
    gem 'jbuilder', '~> 2.7'
    gem 'bootsnap', '>= 1.4.4', require: false
    gem 'pry','~> 0.13.1'
    gem 'pry-rails', '~> 0.3.9'
    gem 'pry-byebug', '~> 3.9.0'
    gem 'redcarpet', '~> 3.5', '>= 3.5.1'
    gem 'devise', '~> 4.2'
    gem 'will_paginate', '~> 3.3'
    gem 'bourbon', '~> 7.0'

    gem_group :development, :test do
      gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    end

    gem_group :development do
      gem 'web-console', '>= 4.1.0'
      gem 'rack-mini-profiler', '~> 2.0'
      gem 'listen', '~> 3.3'
      gem 'spring'
      gem 'amazing_print', '~> 1.2', '>= 1.2.1'
      gem 'better_errors', '~> 2.9', '>= 2.9.1'
      gem 'binding_of_caller', '~> 1.0'
    end

    gem_group :test do
      gem 'capybara', '>= 3.26'
      gem 'selenium-webdriver'
      gem 'webdrivers'
    end

    gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
  rescue => error
    puts error.message
  end
end


create_gemfile

# ------------------------------------------------------------------------------
# Gitignore
# ------------------------------------------------------------------------------

def create_git_ignore
  begin
    # remove gitignore and replace with template ignore.
    remove_file ".gitignore"
    copy_file ".gitignore"
  rescue => error
    puts error.message
  end
end

create_git_ignore

# ------------------------------------------------------------------------------
# remove directorys
# ------------------------------------------------------------------------------

def create_assets
  begin
    # remove standard assest and layouts
    remove_dir 'app/assets/stylesheets'
    remove_dir 'app/views/layouts'
    remove_file 'app/helpers/application_helper.rb'
  rescue => error
    puts error.message
  end
end

create_assets

# ------------------------------------------------------------------------------
# copy template directorys to root
# ------------------------------------------------------------------------------
def create_templates
  begin
    directory "stylesheets", "app/assets/stylesheets"
    directory "layouts", "app/views/layouts"
    copy_file "application_helper.rb", "app/helpers/application_helper.rb"
  rescue => error
    puts error.message
  end
end

create_templates

# ------------------------------------------------------------------------------
#  Lib
# ------------------------------------------------------------------------------
def create_libriary_gens
  begin
    empty_directory 'lib/generators'
    empty_directory 'lib/templates/rails/helper'
    empty_directory 'lib/templates/erb'
    # move templates
    directory "generators/forum", "lib/generators/forum"
    directory "generators/category", "lib/generators/category"
    directory "generators/imageable", "lib/generators/imageable"
  rescue => error
    puts error.message
  end
end

create_libriary_gens

run "spring stop"
