<?php
/*
Plugin Name: phpDoc to WordPress -- Helpers
Plugin URI: http://github.com/paulgibbs/phpdoc-to-wordpress/
Description: Sets up the custom taxonomies used by the phpDoc to WordPress scripts.
Version: 1.0
Requires at least: 3.5
Tested up to: 3.5
License: GPLv2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html
Author: Paul Gibbs
Author URI: http://byotos.com/
Domain Path: /languages/
Text Domain: ptw

"phpDoc to WordPress Helpers"
Copyright (C) 2012 Paul Gibbs

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/**
 * Load any translations for the plugin's textdomain
 *
 * @since 1.0
 */
function ptw_load_textdomain() {
  load_plugin_textdomain( 'ptw', false, dirname( plugin_basename( __FILE__ ) ) . '/languages' ); 
}
add_action( 'plugins_loaded', 'ptw_load_textdomain' );

/**
 * Register the "versions" taxonomy for phpDoc-to-Wordpress
 *
 * The versions taxonomy is populated by the "@since" meta from the data import.
 *
 * @since 1.0
 */
function ptw_register_taxonomy_versions() {
	$labels = array(
		'name'                       => _x( 'Versions', 'ptw' ),
		'singular_name'              => _x( 'Version', 'ptw' ),
		'search_items'               => _x( 'Search Versions', 'ptw' ),
		'popular_items'              => _x( 'Popular Versions', 'ptw' ),
		'all_items'                  => _x( 'All Versions', 'ptw' ),
		'parent_item'                => _x( 'Parent Version', 'ptw' ),
		'parent_item_colon'          => _x( 'Parent Version:', 'ptw' ),
		'edit_item'                  => _x( 'Edit Version', 'ptw' ),
		'update_item'                => _x( 'Update Version', 'ptw' ),
		'add_new_item'               => _x( 'Add New Version', 'ptw' ),
		'new_item_name'              => _x( 'New Version', 'ptw' ),
		'separate_items_with_commas' => _x( 'Separate versions with commas', 'ptw' ),
		'add_or_remove_items'        => _x( 'Add or remove versions', 'ptw' ),
		'choose_from_most_used'      => _x( 'Choose from most used versions', 'ptw' ),
		'menu_name'                  => _x( 'Versions', 'ptw' ),
	);

	$args = array(
		'labels'            => $labels,
		'public'            => true,
		'show_in_nav_menus' => true,
		'show_ui'           => true,
		'show_tagcloud'     => true,
		'hierarchical'      => false,
		'rewrite'           => true,
		'query_var'         => true,
	);

	register_taxonomy( 'versions', array( 'page' ), $args );
}
add_action( 'init', 'ptw_register_taxonomy_versions' );

/**
 * Register the "contexts" taxonomy for phpDoc-to-Wordpress
 *
 * The contexts taxonomy is used to categorise what type of user the documentation is relevant to.
 * For data imports, this is hardcoded to "developer".
 *
 * @since 1.0
 */
function ptw_register_taxonomy_contexts() {
	$labels = array(
		'name'                       => _x( 'Contexts', 'ptw' ),
		'singular_name'              => _x( 'Context', 'ptw' ),
		'search_items'               => _x( 'Search Contexts', 'ptw' ),
		'popular_items'              => _x( 'Popular Contexts', 'ptw' ),
		'all_items'                  => _x( 'All Contexts', 'ptw' ),
		'parent_item'                => _x( 'Parent Context', 'ptw' ),
		'parent_item_colon'          => _x( 'Parent Context:', 'ptw' ),
		'edit_item'                  => _x( 'Edit Context', 'ptw' ),
		'update_item'                => _x( 'Update Context', 'ptw' ),
		'add_new_item'               => _x( 'Add New Context', 'ptw' ),
		'new_item_name'              => _x( 'New Context', 'ptw' ),
		'separate_items_with_commas' => _x( 'Separate contexts with commas', 'ptw' ),
		'add_or_remove_items'        => _x( 'Add or remove Contexts', 'ptw' ),
		'choose_from_most_used'      => _x( 'Choose from most used Contexts', 'ptw' ),
		'menu_name'                  => _x( 'Contexts', 'ptw' ),
	);

	$args = array(
		'labels'            => $labels,
		'public'            => true,
		'show_in_nav_menus' => true,
		'show_ui'           => true,
		'show_tagcloud'     => true,
		'hierarchical'      => false,
		'rewrite'           => true,
		'query_var'         => true,
	);

	register_taxonomy( 'contexts', array( 'page' ), $args );
}
add_action( 'init', 'ptw_register_taxonomy_contexts' );

/**
 * Register the "types" taxonomy for phpDoc-to-Wordpress
 *
 * The types taxonomy is used to further categorise what type of item is being documented.
 * For data imports, this is hardcoded to "classes", "functions", or "methods".
 *
 * @since 1.0
 */
function ptw_register_taxonomy_types() {
	$labels = array(
		'name'                       => _x( 'Types', 'ptw' ),
		'singular_name'              => _x( 'Type', 'ptw' ),
		'search_items'               => _x( 'Search Types', 'ptw' ),
		'popular_items'              => _x( 'Popular Types', 'ptw' ),
		'all_items'                  => _x( 'All Types', 'ptw' ),
		'parent_item'                => _x( 'Parent Type', 'ptw' ),
		'parent_item_colon'          => _x( 'Parent Type:', 'ptw' ),
		'edit_item'                  => _x( 'Edit Type', 'ptw' ),
		'update_item'                => _x( 'Update Type', 'ptw' ),
		'add_new_item'               => _x( 'Add New Type', 'ptw' ),
		'new_item_name'              => _x( 'New Type', 'ptw' ),
		'separate_items_with_commas' => _x( 'Separate types with commas', 'ptw' ),
		'add_or_remove_items'        => _x( 'Add or remove Types', 'ptw' ),
		'choose_from_most_used'      => _x( 'Choose from most used Types', 'ptw' ),
		'menu_name'                  => _x( 'Types', 'ptw' ),
	);

	$args = array(
		'labels'            => $labels,
		'public'            => true,
		'show_in_nav_menus' => true,
		'show_ui'           => true,
		'show_tagcloud'     => true,
		'hierarchical'      => false,
		'rewrite'           => true,
		'query_var'         => true,
	);

	register_taxonomy( 'types', array( 'page' ), $args );
}
add_action( 'init', 'ptw_register_taxonomy_types' );
