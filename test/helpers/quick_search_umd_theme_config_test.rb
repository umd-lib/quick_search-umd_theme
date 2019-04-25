require 'test_helper'
require 'minitest/mock'

class QuickSearchUmdThemeConfigText < ActiveSupport::TestCase
  def setup
  end

  test 'environment_descriptor returns name of environment' do
    Rails.env = 'local'
    config = QuickSearchUmdTheme::Configuration.new
    assert 'Local', config.environment_banner.environment_descriptor
  end

  test 'environment_descriptor with socket' do
    Socket.stub :gethostname, 'search-local.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'Local', config.environment_banner.environment_descriptor
    end

    Socket.stub :gethostname, 'search-dev.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'Development', config.environment_banner.environment_descriptor
    end

    Socket.stub :gethostname, 'search-stage.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'Stage', config.environment_banner.environment_descriptor
    end

    Socket.stub :gethostname, 'search.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_nil config.environment_banner.environment_descriptor
    end
  end

  test 'default_text with socket' do
    Socket.stub :gethostname, 'search-local.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'Local Environment', config.environment_banner.default_text
    end

    Socket.stub :gethostname, 'search-dev.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'Development Environment', config.environment_banner.default_text
    end

    Socket.stub :gethostname, 'search-stage.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'Stage Environment', config.environment_banner.default_text
    end

    Socket.stub :gethostname, 'search.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_nil config.environment_banner.default_text
    end
  end

  test 'default_text with ENVIRONMENT_BANNER variable' do
    ENV['ENVIRONMENT_BANNER'] = 'Foobar'
    config = QuickSearchUmdTheme::Configuration.new
    assert_equal 'Foobar', config.environment_banner.default_text

    ENV['ENVIRONMENT_BANNER'] = ''
    Rails.env = 'development'
    config = QuickSearchUmdTheme::Configuration.new
    assert_equal 'Local Environment', config.environment_banner.default_text

    ENV['ENVIRONMENT_BANNER'] = nil
    Rails.env = 'development'
    config = QuickSearchUmdTheme::Configuration.new
    assert_equal 'Local Environment', config.environment_banner.default_text
  end

  test 'default_css_options with ENVIRONMENT_BANNER_BACKGROUND variable' do
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = 'red'
    config = QuickSearchUmdTheme::Configuration.new

    css_options = config.environment_banner.default_css_options
    assert css_options.has_key?(:style)
    assert_equal 'background-color: red;', css_options[:style]

    assert css_options.has_key?(:class)
    assert_equal 'environment-banner', css_options[:class]

    # Test with empty property
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = ''
    config = QuickSearchUmdTheme::Configuration.new

    css_options = config.environment_banner.default_css_options
    refute css_options.has_key?(:style)
    assert_equal 'environment-banner', css_options[:class]

    # Test with nil property
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = nil
    config = QuickSearchUmdTheme::Configuration.new

    css_options = config.environment_banner.default_css_options
    refute css_options.has_key?(:style)
    assert_equal 'environment-banner', css_options[:class]
  end

  test 'default_css_options with ENVIRONMENT_BANNER_FOREGROUND variable' do
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = 'white'
    config = QuickSearchUmdTheme::Configuration.new

    css_options = config.environment_banner.default_css_options
    assert css_options.has_key?(:style)
    assert_equal 'color: white;', css_options[:style]

    assert css_options.has_key?(:class)
    assert_equal 'environment-banner', css_options[:class]

    # Test with empty property
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = ''
    config = QuickSearchUmdTheme::Configuration.new

    css_options = config.environment_banner.default_css_options
    refute css_options.has_key?(:style)
    assert_equal 'environment-banner', css_options[:class]

    # Test with nil property
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = nil
    config = QuickSearchUmdTheme::Configuration.new

    css_options = config.environment_banner.default_css_options
    refute css_options.has_key?(:style)
    assert_equal 'environment-banner', css_options[:class]
  end

  test 'default_css_options with ENVIRONMENT_BANNER_BACKGROUND and ENVIRONMENT_BANNER_FOREGROUND variables' do
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = 'red'
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = 'white'
    config = QuickSearchUmdTheme::Configuration.new

    css_options =config.environment_banner.default_css_options
    assert css_options.has_key?(:style)
    assert_equal 'background-color: red; color: white;', css_options[:style]

    assert css_options.has_key?(:class)
    assert_equal 'environment-banner', css_options[:class]
  end

  test 'default_css_options "id" handling with socket' do
    Socket.stub :gethostname, 'search-local.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'environment-local', config.environment_banner.default_css_options[:id].downcase
    end

    Socket.stub :gethostname, 'search-dev.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'environment-development', config.environment_banner.default_css_options[:id].downcase
    end

    Socket.stub :gethostname, 'search-stage.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_equal 'environment-stage', config.environment_banner.default_css_options[:id].downcase
    end

    Socket.stub :gethostname, 'search.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert_nil config.environment_banner.default_css_options[:id]
    end
  end

  test 'default_enabled with socket' do
    Socket.stub :gethostname, 'search-local.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert config.environment_banner.default_enabled(config.environment_banner.default_text)
    end

    Socket.stub :gethostname, 'search-dev.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert config.environment_banner.default_enabled(config.environment_banner.default_text)
    end

    Socket.stub :gethostname, 'search-stage.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      assert config.environment_banner.default_enabled(config.environment_banner.default_text)
    end

    Socket.stub :gethostname, 'search.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      refute config.environment_banner.default_enabled(config.environment_banner.default_text)
    end
  end

  test 'default_enabled with ENVIRONMENT_BANNER_ENABLED variable' do
    ENV['ENVIRONMENT_BANNER_ENABLED'] = 'true'
    text = 'Local Environment'
    config = QuickSearchUmdTheme::Configuration.new
    assert config.environment_banner.default_enabled(text)

    ENV['ENVIRONMENT_BANNER_ENABLED'] = 'false'
    text = 'Local Environment'
    config = QuickSearchUmdTheme::Configuration.new
    refute config.environment_banner.default_enabled(text)

    # Don't show banner if there is no text to display
    ENV['ENVIRONMENT_BANNER_ENABLED'] = 'true'
    text = ''
    config = QuickSearchUmdTheme::Configuration.new
    refute config.environment_banner.default_enabled(text)

    # Can show banner in production, if ENVIRONMENT_BANNER is set
    Socket.stub :gethostname, 'search.lib.umd.edu' do
      config = QuickSearchUmdTheme::Configuration.new
      ENV['ENVIRONMENT_BANNER'] = 'Production Release'
      assert config.environment_banner.default_enabled(config.environment_banner.default_text)
    end
  end

  def teardown
    ENV.clear
    Rails.env = 'test'
  end
end