require 'test_helper'
require 'minitest/mock'

class UmdEnvironmentBannerHelperTest < ActiveSupport::TestCase
  def setup
    reset_configuration
    @helper = Object.new
    @helper.extend(ActionView::Helpers::TagHelper)
    @helper.extend(QuickSearchUmdTheme::UmdEnvironmentBannerHelper)
  end

  # Resets the configuration
  def reset_configuration
    QuickSearchUmdTheme.configuration = QuickSearchUmdTheme::Configuration.new
  end

  test 'environment_banner returns expected tag' do
    Socket.stub :gethostname, 'search-local.lib.umd.edu' do
      reset_configuration
      assert_equal(
        '<div id="environment-local" class="environment-banner">Local Environment</div>',
        @helper.environment_banner
      )
    end

    Socket.stub :gethostname, 'search-dev.lib.umd.edu' do
      reset_configuration
      assert_equal(
        '<div id="environment-development" class="environment-banner">Development Environment</div>',
        @helper.environment_banner
      )
    end


    Socket.stub :gethostname, 'search-stage.lib.umd.edu' do
      reset_configuration
      assert_equal(
        '<div id="environment-stage" class="environment-banner">Stage Environment</div>',
        @helper.environment_banner
      )
    end


    Socket.stub :gethostname, 'search.lib.umd.edu' do
      reset_configuration
      assert_nil @helper.environment_banner
    end


    ENV['ENVIRONMENT_BANNER'] = 'Alpha Release'
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = 'yellow'
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = 'black'

    Socket.stub :gethostname, 'search.lib.umd.edu' do
      reset_configuration
      assert_equal(
        '<div style="background-color: yellow; color: black;" class="environment-banner">Alpha Release</div>',
        @helper.environment_banner
      )
    end
  end

  def teardown
    ENV.clear
    Rails.env = 'test'
  end
end