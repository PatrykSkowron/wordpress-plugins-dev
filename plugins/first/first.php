<?php
/**
 * Plugin Name: My first plugin
 */

add_action( 'the_content', 'my_thank_you_text' );

function my_thank_you_text ( $content ) {
    $content .= '<p>Thank you for reading!</p>';
    return $content;
}

?>