# frozen_string_literal: true

require 'socket'

module QuickSearchUmdTheme
  # This Helper creates the "UMD Environment Banner" as required by
  # https://confluence.umd.edu/display/LIB/Create+Environment+Banners
  module UmdEnvironmentBannerHelper
    # Returns the HTML tag for the environment banner, or nil if no banner
    # should be displayed.
    def environment_banner
      QuickSearchUmdTheme.configure
      return unless QuickSearchUmdTheme.configuration.environment_banner.enabled?
      banner_text = QuickSearchUmdTheme.configuration.environment_banner.text
      css_options = QuickSearchUmdTheme.configuration.environment_banner.css_options
      content_tag(:div, banner_text, css_options)
    end
  end
end
