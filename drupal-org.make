api = 2
core = 7.x

; Base

projects[addressfield][type] = module
projects[addressfield][subdir] = contrib

projects[autocomplete_deluxe][type] = module
projects[autocomplete_deluxe][subdir] = contrib

projects[bean][type] = module
projects[bean][subdir] = contrib

projects[colorbox][type] = module
projects[colorbox][subdir] = contrib

projects[context][type] = module
projects[context][subdir] = contrib

projects[ctools][version] = 1.2
projects[ctools][type] = module
projects[ctools][subdir] = contrib
projects[ctools][patch][] = http://drupal.org/files/ctools-dependent-js-broken-with-jquery-1.7-1494860-30.patch

projects[date][type] = module
projects[date][subdir] = contrib

;projects[delta][type] = module
;projects[delta][subdir] = contrib

projects[ds][type] = module
projects[ds][subdir] = contrib

projects[email][type] = module
projects[email][subdir] = contrib

projects[entity][type] = module
projects[entity][subdir] = contrib

projects[entityreference][type] = module
projects[entityreference][subdir] = contrib

;projects[facetapi][type] = module
;projects[facetapi][subdir] = contrib

projects[features][version] = 1.0
projects[features][type] = module
projects[features][subdir] = contrib
projects[features][patch] = http://drupal.org/files/features_986968_20_shortcut_sets.patch
projects[features][patch] = http://drupal.org/files/features-1272586-32.patch
projects[features][patch] = http://drupal.org/files/1064472_features_field_split_23.patch
projects[features][patch] = http://drupal.org/files/features-escape-markup-1885482-2.patch

projects[features_override][type] = module
projects[features_override][subdir] = contrib

projects[field_collection][type] = module
projects[field_collection][subdir] = contrib

projects[field_group][type] = module
projects[field_group][subdir] = contrib

projects[file_entity][version] = 2.0-unstable7
projects[file_entity][type] = module
projects[file_entity][subdir] = contrib

projects[flag][type] = module
projects[flag][subdir] = contrib

projects[flexslider][type] = module
projects[flexslider][subdir] = contrib

projects[geolocation][type] = module
projects[geolocation][subdir] = contrib

projects[honeypot][type] = module
projects[honeypot][subdir] = contrib

projects[internal_nodes][type] = module
projects[internal_nodes][subdir] = contrib

projects[jquery_update][type] = module
projects[jquery_update][subdir] = contrib

projects[libraries][type] = module
projects[libraries][subdir] = contrib

projects[link][type] = module
projects[link][subdir] = contrib

projects[media][version] = 2.0-unstable7
projects[media][type] = module
projects[media][subdir] = contrib

projects[media_colorbox][type] = module
projects[media_colorbox][subdir] = contrib

projects[media_youtube][type] = module
projects[media_youtube][subdir] = contrib

projects[media_vimeo][type] = module
projects[media_vimeo][subdir] = contrib

projects[override_node_options][type] = module
projects[override_node_options][subdir] = contrib

projects[panels][type] = module
projects[panels][subdir] = contrib

projects[pathauto][type] = module
projects[pathauto][subdir] = contrib

projects[print][type] = module
projects[print][subdir] = contrib

projects[rules][version] = 2.2
projects[rules][type] = module
projects[rules][subdir] = contrib
projects[rules][patch][] = http://drupal.org/files/rules-operations-link-class-1655534-1.patch

;projects[search_api][type] = module
;projects[search_api][subdir] = contrib

;projects[search_api_db][type] = module
;projects[search_api_db][subdir] = contrib

;projects[search_api_page][type] = module
;projects[search_api_page][subdir] = contrib

;projects[search_api_solr][type] = module
;projects[search_api_solr][subdir] = contrib

projects[strongarm][type] = module
projects[strongarm][subdir] = contrib

projects[token][type] = module
projects[token][subdir] = contrib

projects[transliteration][type] = module
projects[transliteration][subdir] = contrib

projects[variable][type] = module
projects[variable][subdir] = contrib

projects[views][type] = module
projects[views][subdir] = contrib

projects[views_arguments_extras][type] = module
projects[views_arguments_extras][subdir] = contrib

projects[views_slideshow][type] = module
projects[views_slideshow][subdir] = contrib

projects[webform][type] = module
projects[webform][subdir] = contrib

; Administration

projects[admin_menu][type] = module
projects[admin_menu][subdir] = contrib

projects[admin_views][type] = module
projects[admin_views][subdir] = contrib

projects[backup_migrate][type] = module
projects[backup_migrate][subdir] = contrib

projects[better_exposed_filters][type] = module
projects[better_exposed_filters][subdir] = contrib

projects[draggableviews][type] = module
projects[draggableviews][subdir] = contrib

projects[itoggle][type] = module
projects[itoggle][subdir] = contrib

projects[views_bulk_operations][type] = module
projects[views_bulk_operations][subdir] = contrib

projects[wysiwyg][type] = module
projects[wysiwyg][subdir] = contrib

; Development

projects[addanother][type] = module
projects[addanother][subdir] = contrib

projects[advanced_help][type] = module
projects[advanced_help][subdir] = contrib

projects[coder][type] = module
projects[coder][subdir] = contrib

projects[devel][type] = module
projects[devel][subdir] = contrib

projects[drupal_ipsum][type] = module
projects[drupal_ipsum][subdir] = contrib

projects[filter_perms][type] = module
projects[filter_perms][subdir] = contrib

projects[masquerade][type] = module
projects[masquerade][subdir] = contrib

projects[migrate][type] = module
projects[migrate][subdir] = contrib

projects[migrate_d2d][type] = module
projects[migrate_d2d][subdir] = contrib

projects[migrate_extras][type] = module
projects[migrate_extras][subdir] = contrib

projects[module_filter][type] = module
projects[module_filter][subdir] = contrib

;projects[omega_tools][type] = module
;projects[omega_tools][subdir] = contrib

;projects[borealis][type] = module
;projects[borealis][subdir] = contrib

; SEO

projects[globalredirect][type] = module
projects[globalredirect][subdir] = contrib

projects[metatag][type] = module
projects[metatag][subdir] = contrib

projects[metatag_views][type] = module
projects[metatag_views][subdir] = custom
projects[metatag_views][download][type] = git
projects[metatag_views][download][url] = http://git.drupal.org/sandbox/davereid/1281614.git
projects[metatag_views][download][branch] = 7.x-1.x
projects[metatag_views][patch][] = http://drupal.org/files/1560024-views_metatags-ajax-error.patch
projects[metatag_views][patch][] = http://drupal.org/files/1560088-display_extender-export.patch
projects[metatag_views][patch][] = http://drupal.org/files/1361158-html_output.patch

projects[redirect][type] = module
projects[redirect][subdir] = contrib

projects[rich_snippets][type] = module
projects[rich_snippets][subdir] = contrib

;projects[search404][type] = module
;projects[search404][subdir] = contrib

projects[schemaorg][type] = module
projects[schemaorg][subdir] = contrib

projects[xmlsitemap][type] = module
projects[xmlsitemap][subdir] = contrib

; Performance

projects[bootstrap_optimizer][type] = module
projects[bootstrap_optimizer][subdir] = contrib

projects[boost][type] = module
projects[boost][subdir] = contrib

projects[core_library][type] = module
projects[core_library][subdir] = contrib

projects[entitycache][type] = module
projects[entitycache][subdir] = contrib

; Themes

projects[tao][type] = theme

projects[rubik][type] = theme

projects[fubik][type] = theme

;projects[omega][type] = theme

;projects[zen][type] = theme

;projects[aurora][type] = theme

; External Libraries

libraries[SolrPhpClient][download][type] = get
libraries[SolrPhpClient][download][url] = http://solr-php-client.googlecode.com/files/SolrPhpClient.r60.2011-05-04.zip

libraries[colorbox][download][type] = get
libraries[colorbox][download][url] = http://jacklmoore.com/colorbox/colorbox.zip

;libraries[ckeditor][download][type] = get
;libraries[ckeditor][download][url] = http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.4/ckeditor_3.6.4.tar.gz

libraries[engage.itoggle][download][type] = get
libraries[engage.itoggle][download][url] = http://labs.engageinteractive.co.uk/itoggle/engage.itoggle.zip

libraries[jquery.scrollto][download][type] = file
libraries[jquery.scrollto][download][url] = http://flesler-plugins.googlecode.com/files/jquery.scrollTo-1.4.2-min.js

libraries[jquery.easing][download][type] = file
libraries[jquery.easing][download][url] = http://gsgd.co.uk/sandbox/jquery/easing/jquery.easing.1.3.js

libraries[jquery.hoverintent][download][type] = file
libraries[jquery.hoverintent][download][url] = http://cherne.net/brian/resources/jquery.hoverIntent.minified.js

libraries[jquery.cycle][download][type] = file
libraries[jquery.cycle][download][url] = http://malsup.github.com/jquery.cycle.all.js

libraries[flexslider][download][type] = file
libraries[flexslider][download][url] = https://github.com/woothemes/FlexSlider/zipball/master

libraries[jcarousel][download][type] = file
libraries[jcarousel][download][url] = https://github.com/jsor/jcarousel/tarball/0.2.8

libraries[tinymce][download][type] = file
libraries[tinymce][download][url] = http://github.com/downloads/tinymce/tinymce/tinymce_3.5.6_jquery.zip

libraries[jquery.coolinput][download][type] = file
libraries[jquery.coolinput][download][url] = https://github.com/alexweber/jquery.coolinput/tarball/2.0.1

libraries[chosen][download][type] = file
libraries[chosen][download][url] = https://github.com/harvesthq/chosen/archive/v0.9.8.tar.gz