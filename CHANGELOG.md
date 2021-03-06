# Release Notes - Spice - Version 1.0.6

* Passing a string for the client key is now valid, as it should have been for a while.

# Release Notes - Spice - Version 1.0.5

* `mixlib-authentication` introduced a breaking change in their bump to 1.3.0. Pinned mixlib-auth to 1.1.4 so Spice works again.
* `Spice.read_key_file` can now parse a relative path

# Release Notes - Spice - Version 1.0.4

* Fix hosted Chef usage - https://github.com/danryan/spice/pull/23
* 

# Release Notes - Spice - Version 1.0.3

* Fix create_node method. This was throwing a Spice::Error::NotFound exception because it was generating a wrong path (/nodes//nodes/...). The get_node() call at the end of the method returns the full node object. If just the attributes were used to create the node object, many things were missing.

# Release Notes - Spice - Version 1.0.2

* Fixed issue with bad variable when checking the format of a client key.

# Release Notes - Spice - Version 1.0.1

* Fixed an incompatibility with JRuby and Yajl by switching to MultiJson.

# Release Notes - Spice - Version 1.0.0

* Note: this version of Spice is a major version bump, which means it is *not* backwards-compatible with previous versions.

## Removed

* Old-style connections are no longer supported. Please use the connection string like Chef uses (ex. http://chef.example.com:4000)

## Improvement

* Complete rewrite! Returned results are now full interactive objects and not just hashes. Create, update, and destroy resources with an ORM-like interface.

# Release Notes - Spice - Version 0.5.0

## Bug

* url_path was not being reset
* added `chef_version` config variable to fix some people's issues with require `chef/version`

## Improvement

* Node support!

# Release Notes - Spice - Version 0.3.0

## Bug

* N/A

## Improvement

* Improved specification of DataBag class
* Added additional documentation to DataBag class
* Add CHANGELOG

## New Feature

* Data bag items can now be created

