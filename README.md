# quick_search-umd_theme

A gem engine providing the UMD Libraries theme used with NCSU Quick Search

This code originated from the NCSU quick_search-generic theme
[https://github.com/NCSU-Libraries/quick_search-generic_theme][1].

## Usage

Include this gem in your QuickSearch gemfile

```
  gem 'quick_search-umd_theme'
```

Add 'quick_search_umd_theme' to the theme configuration key in
quick_search_config.yml.

When changing themes, run

```
> rake assets:clobber
```

to remove any pre-compiled remmants of the previous theme.

## Environment Banner

In keeping with [SSDR policy][2], an "environment banner" will be displayed at
the top of each page when running on non-production servers, indicating whether
the application is running on a "Local", "Development", or "Staging" server.
This banner does not appear on production systems.

The environment banner will attempt to auto-detect the correct environment. To
override this auto-detection functionality (or to modify it for testing), the
following environment variables can be used, all of which are optional:

* ENVIRONMENT_BANNER - the human-readable text to display in the banner
* ENVIRONMENT_BANNER_FOREGROUND - The color for the banner text (using CSS
    color codes). When using hexadecial codes, enclose the code in
    single quotes (i.e., '#00ffff').
* ENVIRONMENT_BANNER_BACKGROUND - The color for the banner background (using CSS
    color codes). When using hexadecial codes, enclose the code in
    single quotes (i.e., '#00ffff').
* ENVIRONMENT_BANNER_ENABLED - Set to "true" to display the banner when it
    otherwise would not (for example, on a production server). The
    "ENVIRONMENT_BANNER" variable must also be set.

The environment banner can also be configured using an initializer in the
application, i.e. "config/initializers/quick_search_umd_theme.rb":

```
  QuickSearchUmdTheme.configure do |config|
    # These settings override any settings in the environment variables
    config.environment_banner.text = 'Alpha Release'
    config.environment_banner.css_options = {
      style: 'color: red; background-color: yellow;',
      class: 'environment-banner'
    }
    config.environment_banner.enabled = true
  end
```

**Note:** The environment banner configuration is cached when the application
is started, so any changes to the configuration will require an application
restart.

----

[1]: https://github.com/NCSU-Libraries/quick_search-generic_theme
[2]: https://confluence.umd.edu/display/LIB/Create+Environment+Banners