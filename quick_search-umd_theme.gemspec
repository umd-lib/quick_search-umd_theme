# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'quick_search_umd_theme/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'quick_search-umd_theme'
  s.version     = QuickSearchUmdTheme::VERSION
  s.authors     = ['UMD Libraries']
  s.email       = ['lib-ssdr@umd.edu']
  s.homepage    = 'https://www.lib.umd.edu/'
  s.summary     = 'UMD theme for QuickSearch'
  s.description = 'UMD theme gem engine plugin for QuickSearch.'
  s.license = 'Apache 2.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'compass', '~> 1.0'
  s.add_dependency 'compass-rails', '~> 3.0'
  s.add_dependency 'font-awesome-sass', '~> 4.4'
  s.add_dependency 'foundation-rails', '5.4.5'
  s.add_dependency 'quick_search-core', '~> 0.1'
  s.add_dependency 'sass', '~> 3.2'
  s.add_dependency 'sass-rails', '~> 5.0'

  s.add_development_dependency('byebug')
  s.add_development_dependency('rubocop', '0.52.1')
  s.add_development_dependency('sqlite3')
end
