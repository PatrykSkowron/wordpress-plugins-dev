<?php
/**
 * Plugin Name: Plugin with options
 */

add_action( 'the_content', 'my_footer' );

function my_footer ( $content ) {
    $footer_text = get_option("footer_text");
    $content .= "<p>${footer_text}";
    return $content;
}

/* admin stuff here, to add options */

/** Step 2 (from text above). */
if ( is_admin() ){ // admin actions
  add_action( 'admin_menu', 'plugin_menu' );
  add_action('admin_init', 'plugin_admin_init');
} else {
  // non-admin enqueues, actions, and filters
}

/** this is how plugin menu will look like (plugin_options)*/
function plugin_menu() {
	add_options_page( 'My Plugin Options', 'My Plugin', 'manage_options', 'my-unique-identifier', 'plugin_options');
}

/** Step 3. */
function plugin_options() {
	if ( !current_user_can( 'manage_options' ) )  {
		wp_die( __( 'You do not have sufficient permissions to access this page.' ) );
	}
?>

<div class="wrap">
<p>Here is where the form would go if I actually had options.</p>
<form method="post" action="options.php">
<?php settings_fields('plugin_options'); ?>
<?php do_settings_sections('plugin'); ?>
<?php submit_button(); ?>
</form>
</div>

<?php
}
?>


<?php // add the admin settings and such
function plugin_admin_init(){
register_setting('plugin_options', 'footer_text');
add_settings_section('plugin_main', 'Main Settings', 'plugin_section_text', 'plugin');
add_settings_field('footer_text', 'Footer text', 'plugin_setting_footer_text', 'plugin', 'plugin_main');
}?>

<?php function plugin_section_text() {
echo '<p>Main description of this section here.</p>';
} ?>

<?php function plugin_setting_footer_text() {
$options = get_option('footer_text');
?>
<input type="text" name="footer_text" id="footer_text" value="<?php echo $options; ?>" />
<?php
} ?>

