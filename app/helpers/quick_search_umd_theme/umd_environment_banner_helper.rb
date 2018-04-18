require 'socket'

module QuickSearchUmdTheme
  # This Helper does the "UMD Environment Banner"
  # https://confluence.umd.edu/display/LIB/Create+Environment+Banners
  module UmdEnvironmentBannerHelper
    ENVIRONMENT_NAME = if ENV['ENVIRONMENT_BANNER']
                         ENV['ENVIRONMENT_BANNER'].humanize.freeze
                       elsif Rails.env.development?
                         'Local'.freeze
                       elsif Socket.gethostname =~ /(local|dev|stage)\./
                         $LAST_MATCH_INFO.captures
                                         .first
                                         .gsub('dev', 'development')
                                         .humanize
                                         .freeze
                       end

    def environment_banner
      return unless ENVIRONMENT_NAME
      content_tag(:div, "#{ENVIRONMENT_NAME.humanize} Environment",
                  class: 'environment-banner',
                  id: "environment-#{ENVIRONMENT_NAME.downcase}")
    end
  end
end
