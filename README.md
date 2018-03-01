# quick_search-umd_theme

A gem engine providing the UMD Libraries theme used with NCSU Quick Search

This code originated from the NCSU quick_search-generic theme
[https://github.com/NCSU-Libraries/quick_search-generic_theme]
(https://github.com/NCSU-Libraries/quick_search-generic_theme).

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
