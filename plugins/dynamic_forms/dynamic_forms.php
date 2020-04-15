<?php
/**
 * Plugin Name: Dynamic forms
 */

add_action( 'the_content', 'add_dynamic_forms' );

function add_dynamic_forms ( $content ) {
    require_once('functions.php');
    $select_options1 = get_option("select_options1");
    $select_options1_array = explode(",",$select_options1);

    $selections = "";
    $selections .= selectAnything($select_options1_array,"basic_select1");

    $content .= add_form($selections);
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
	add_options_page( 'My Plugin Options', 'Dynamic forms', 'manage_options', 'my-unique-identifier', 'plugin_options');
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
register_setting('plugin_options', 'select_options1');
add_settings_section('plugin_main', 'Main Settings', 'plugin_section_text', 'plugin');
add_settings_field('select_options1', 'Select1', 'plugin_setting_select1', 'plugin', 'plugin_main');
}?>

<?php function plugin_section_text() {
echo '<p>Main description of this section here.</p>';
} ?>

<?php function plugin_setting_select1() {
$options = get_option('select_options1');
?>
<input type="text" name="select_options1" id="select_options1" value="<?php echo $options; ?>" />
<?php
} ?>

