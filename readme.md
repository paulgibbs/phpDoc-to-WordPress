# phpDoc to WordPress
phpDoc to WordPress exports documentation generated by phpDocumentor 2 into WordPress. [Download from Github](https://github.com/paulgibbs/phpDoc-to-WordPress/).

## How it works
You transform an XML file from phpDocumentor using a supplied XSLT file, which converts the XML into a WordPress export file ready for import into your WordPress site. [Browse the Achievements documentation](http://achievementsapp.com/achievements-3-documentation/) to see an example.

## What’s in the box
* Two XSLT scripts; one to make an import file for classes, the other to make an import file for functions and methods.
* A WordPress plugin which sets up three custom taxonomies used by the imports; versions (mapped to phpDoc’s @since), contexts (hardcoded to “developer”), and types (used to further categorise what type of item is being documented; hardcoded to “classes”, “functions”, or “methods”).
* My Achievements plugin‘s current structure.xml file, as a sample for your convenience.

## Changelog
Version 1.0 - First release.

[Find more information and instructions on byotos.com](http://byotos.com/phpdoc-to-wordpress/).