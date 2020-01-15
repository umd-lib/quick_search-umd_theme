require 'quick_search_umd_theme/engine'

# UMD Theme for quick search application
module QuickSearchUmdTheme
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :environment_banner

    def initialize
      @environment_banner = EnvironmentBannerConfiguration.new
    end
  end

  # Configures the environment banner.
  #
  # The default configuration uses the following environment variables,
  # all of which are optional:
  #
  # ENVIRONMENT_BANNER - The exact text to display in the banner
  # ENVIRONMENT_BANNER_FOREGROUND - The color for the banner text (using CSS
  #   color codes). When using hexadecial codes, enclose the code in
  #   single quotes (i.e., '#00ffff').
  # ENVIRONMENT_BANNER_BACKGROUND - The color for the banner background (using
  #   CSS color codes). When using hexadecial codes, enclose the code in
  #   single quotes (i.e., '#00ffff').
  # ENVIRONMENT_BANNER_ENABLED - Set to "true" to display the banner when it
  #   otherwise would not (for example, on a production server). The
  #  "ENVIRONMENT_BANNER" variable must also be set.
  #
  # Instead of using environment variables, the configuration can also be set
  # using an initializer in the application, i.e.
  #
  # config/initializers/quick_search_umd_theme.rb
  #
  # -----
  # QuickSearchUmdTheme.configure do |config|
  #   # These settings override any settings in the environment variables
  #   config.environment_banner.text = 'Alpha Release'
  #   config.environment_banner.css_options = {
  #     style: 'color: red; background-color: yellow;',
  #     class: 'environment-banner'
  #   }
  #   config.environment_banner.enabled = true
  # end
  # -----

  class EnvironmentBannerConfiguration
    attr_accessor :text
    attr_accessor :css_options
    attr_accessor :enabled

    def initialize
      @text = default_text
      @css_options = default_css_options
      @enabled = default_enabled(@text)
    end

    def enabled?
      @enabled
    end

    # Returns the text to display in the environment banner.
    #
    # Implementation: Returns the value of the ENVIRONMENT_BANNER property, if
    # non-empty. Otherwise, the text returned by the "environment_descriptor"
    # method is returned, with " Environment" appended.
    #
    # This method may return nil, if there is no ENVIRONMENT_BANNER, and
    # the environment_desriptor returns nil.
    def default_text
      if ENV['ENVIRONMENT_BANNER'].present?
         ENV['ENVIRONMENT_BANNER'].freeze
      elsif environment_descriptor
        (environment_descriptor + ' Environment').freeze
      end
    end

    # Returns the CSS options to use with the environment banner.
    #
    # Implementation: Uses the ENVIRONMENT_BANNER_BACKGROUND and
    # ENVIRONMENT_BANNER_FOREGROUND properties, if provided. Also returns an
    # "id" field, based on the environment_descriptor, if non-nil.
    def default_css_options
      css_options = {}
      css_style = ''

      background_color = ENV['ENVIRONMENT_BANNER_BACKGROUND']
      foreground_color = ENV['ENVIRONMENT_BANNER_FOREGROUND']

      if background_color.present?
        css_style = "background-color: #{background_color};"
      end

      if foreground_color.present?
        css_style += " color: #{foreground_color};"
        css_style.strip!
      end

      if !css_style.blank?
        css_options[:style] = css_style
      end

      if environment_descriptor
        css_options[:id] = "environment-#{environment_descriptor.gsub(/\W/i, '_').underscore}"
      end

      css_options[:class] = 'environment-banner'
      css_options
    end

    # Returns true if the banner should be displayed, false otherwise.
    #
    # text - the text (if any) being displayedin the banner
    def default_enabled(text)
      env_var_enabled = ENV['ENVIRONMENT_BANNER_ENABLED']

      # Don't display the banner if there is no text
      has_display_text = text.present? && !text.empty?
      return false unless has_display_text

      # Display in ENVIRONMENT_BANNER_ENABLED is not provided or empty
      return true if env_var_enabled.nil? || env_var_enabled.empty?

      # Any value other than "true" is false
      env_var_enabled.strip.downcase == 'true'
    end

    # Returns a description of the running environment (Local, Development,
    # Stage), or nil if the environment can't be determined.
    #
    # Implementation: Returns 'Local', if Rails.env.development?, or "Local",
    # "Development", "Stage", if the hostname constains "local.", "dev.", or
    # "stage.", otherwise returns nil.
    def environment_descriptor
      if Rails.env.development?
        'Local'
      elsif Socket.gethostname =~ /(local|dev|stage)\./
        Regexp.last_match.captures
                          .first
                          .gsub('dev', 'development')
                          .humanize
      end
    end
  end
end
