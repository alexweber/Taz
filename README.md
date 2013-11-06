# Taz

Taz is a tool for VERY quickly spinning up Drupal 7 sites with a bunch of stuff preconfigured to save you time! Taz, spinning, get it?

It includes a shell script, makfile and installation profile.

## Updated! 11/06/13

This hasn't been worked on in a while and was a good start but not the greatest implementation.
Development has resumed in the new [TazNG](https://github.com/alexweber/TazNG) project.

## Getting started

* Download or clone the "bin" branch.
* Copy "taz.sh" into an empty directory.
* Run ```sh taz.sh``` and watch in awe!

## Read more

### Shell Script

It's in the "bin" branch.
This is where the magic happens!

* Download and build the makefile
* Setup custom and contrib subdirectories for modules as well as a private files directory
* Creates MySQL user and database (optional)
* Installs site using Taz profile
* Makes settings.php read-only
* Optionally move the files directory out of default and into sites root
* Pick between Search API and Core Drupal Search and conditionally downloads and enables necessary modules
* Optionally download and enable modules for Multilingual sites
* Pick from Zen, Omega and Aurora and automatically setup a base theme
* Opens the website on the password recovery screen

The entire process only takes a few seconds and can save your team hours of work, time and time again!

Be awesome: Use it with Vagrant.

### Profile

It's in the "profile" branch.
The profile pre-installs some development modules, sets up an admin theme, preconfigures the WYSIWYG editor and a bunch of other cool stuff with sensible defaults.

Don't be alarmed by the number of modules we download; most are disabled by default.
They do, however, have their recommended versions and sometimes even patches applied so that, when you do need them, you'll have right one.
