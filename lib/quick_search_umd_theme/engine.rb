require 'rubygems'
require 'sass-rails'
require 'compass'
require 'compass-rails'
require 'foundation-rails'
require 'font-awesome-sass'

module QuickSearchUmdTheme
  # Rails Engine for quick search application
  class Engine < ::Rails::Engine
    isolate_namespace QuickSearchUmdTheme
    config.to_prepare do
      Rails.application.config.assets.precompile += %w[
        quicksearch_umd_theme/*
      ]
    end
  end
end
