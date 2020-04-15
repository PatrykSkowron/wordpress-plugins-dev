<?php

function sayWhat($what){
    echo("Saying: {$what}\n");
}


function selectAnything($choices, $id){
echo(
"<p>
<select id='{$id}' name='{$id}'>");

foreach ($choices as $item) {
echo("<option value={$item}>{$item}</option>");
}

echo('</select>
</p>');
}

function add_form($body){
$url = esc_url( admin_url( 'admin-post.php' ));
echo "<form action={$url} method='post'>";
echo $body;
echo '<input type="submit">';
echo '</form>';
}
?>