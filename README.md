# Taz

Taz is a tool for VERY quickly spinning up Drupal 7 sites with a bunch of stuff preconfigured to save you time! Taz, spinning, get it?

It includes a shell script, makfile and installation profile.

## Getting started

* Dowload the "taz.make" and "taz.sh" from the "bin" branch into an empty directory
* Run ```sh taz.sh``` and watch in awe.

## Read more

### Shell Script

This is where the magic happens. See the code comments in taz.sh for a closer look at what's going on.

### Profile

The profile installs and configures a bunch of stuff automatically to save you time:

* Enables Fubik Admin theme
* Enables Admin Menu, Admin Views, Devel, Module Filter and some other nice dev modules and settings
* Configures TinyMCE editor and WYSIWYG profiles and text formats
* Configures Backup & Migrate profiles, destinations and schedules
* Sets default Pathauto patterns for nodes in general and Basic pages
* Enables transliteration on both file uploads and pathauto aliases
* Creates default Contexts for administrative pages, user-facing pages and the front page
* Introduces 2 new useful API functions:
** user_has_role() - checks whether a given user has a given role
** string_to_slug() - converts a string into a slug for use in CSS classes and ids as well as paths
* More stuff I can't remeber right now! :)

### Makefile

Don't be alarmed by the number of modules we download; almost all of them are disabled by default.
They do, however, have their recommended versions and sometimes even patches applied so that, when you do need them, you'll have right one.

#### Core

Includes the following modules for general-purpose site building:

* Apps
* Address Field
* Address Field Static Map
* Autocomplete Deluxe
* Bean
* Bundle Inherit
* Colorbox
* Context
* Chaos tool suite (CTools)
* Date
* Delta
* Display Suite
* Email Field
* Entity API
* Entity reference
* Facet API
* Features
* Features Override
* Field Collection
* Field Group
* File Entity
* Flag
* Internal Nodes
* jQuery Update
* Libraries API
* Link
* Media
* Media Colorbox
* Media Youtube
* Override Node Options
* Panels
* Pathauto
* Printer, email and PDF versions
* Rules
* Search API
* Search API Database Search
* Search API Pages
* Search API Solr Search
* Strongarm
* Token
* Transliteration
* Variable
* Views
* Views Argument Extras
* Views Slideshow
* Webform

#### Development

Includes the following modules for development:

* Add Another
* Advanced Help
* Coffee
* Defaultcontent
* Devel
* Drupal Ipsum
* Filter Permissions
* Masquerade
* Module Filter
* Omega Tools

#### Administration

Includes the following modules for improving site administration:

* Administration Menu
* Administration Views
* Backup & Migrate
* Better Exposed Filters
* DraggableViews
* iToggle
* Views Bulk Operations (VBO)
* WYSIWYG

#### SEO

Includes the following modules:

* Metatag
* Metatag Views (patched sandbox)
* Redirect
* Search 404
* Schema.org
* XML sitemap

#### Performance

Includes the following modules:

* Boost
* Core Library
* Entity Cache