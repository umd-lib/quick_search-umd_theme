# frozen_string_literal: true

require 'socket'

module QuickSearchUmdTheme
  # This Helper does the "UMD Environment Banner"
  # https://confluence.umd.edu/display/LIB/Create+Environment+Banners
  module UmdEnvironmentBannerHelper
    ENVIRONMENT_NAME = if ENV['ENVIRONMENT_BANNER']
                         ENV['ENVIRONMENT_BANNER'].freeze
                       elsif Rails.env.development?
                         'Local'
                       elsif Socket.gethostname =~ /(local|dev|stage)\./
                         $LAST_MATCH_INFO.captures
                                         .first
                                         .gsub('dev', 'development')
                                         .humanize
                                         .freeze
                       end

    def environment_banner
      return unless ENVIRONMENT_NAME
      content_tag(:div, "#{ENVIRONMENT_NAME} Environment",
                  class: 'environment-banner',
                  id: "environment-#{ENVIRONMENT_NAME.gsub(/\W/i, '_').underscore}")
    end
  end
end
