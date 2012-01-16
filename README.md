# Spice - Chef API Wrapper [![Dependency Status](https://gemnasium.com/danryan/spice.png)][gemnasium]

[gemnasium]: https://gemnasium.com/danryan/spice

Spice is a zesty Chef API wrapper. Its primary purpose is to let you easily integrate your apps with a [Chef](http://opscode.com/chef) server. Spice provides support for the [Chef API](http://wiki.opscode.com/display/chef/Server+API)

## Installation

Install this beast via Rubygems:

    gem install spice
    
Of course, You can always grab the source from http://github.com/danryan/spice.

### Deprecation notice

Explicitly setting a `host`, `port`, and `scheme` value has been deprecated in favor of setting a single variable, `server_url`, which matches the format of Chef's client config parameter, `chef_server_url`. The old way of defining `host`, `port`, and `scheme` has been removed.

### Contributors

* [Ian Meyer](https://github.com/imeyer) - Opscode Platform support
* [Holger Just](https://github.com/meineerde) - Search functionality
* [Sean Porter](https://github.com/portertech) - Platform bug fixes

### Hat tip

Spice is very heavily inspired by the [Twitter gem](http://github.com/jnunemaker/twitter). Mad props to those folks.

## Contributing to spice
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Dan Ryan. See LICENSE.txt for
further details.

