# frozen_string_literal: true

Rails.application.routes.draw do
  mount QuickSearchUmdTheme::Engine => '/quick_search_umd_theme'
end
