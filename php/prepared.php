<?php
/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2015-02-28 14:54:20
 * @version $Id$
 */

?>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Examples</title>
<meta name="description" content="">
<meta name="keywords" content="">
<link href="" rel="stylesheet">
</head>
<body>
    <h1>book-o-rama entry result</h1>
    <?php
    $isbn=$_POST["isbn"];
    $author=$_POST["author"];
    $title=$_POST["title"];
    $price=$_POST["price"];

    if(!get_magic_quotes_gpc()){
    	$isbn=addslashes($isbn);
    	$author=addslashes($author);
    	$title=addslashes($title);
    	$price=doubleval($price);
    }

    @$db=new mysqli("localhost","kk","123321q","books");

    if(mysqli_connect_errno()){
    	echo "can not connect datebase";
    	exit;
    }

    $query="insert into books values(?,?,?,?)";
    $stm=$db->prepare($query);
    $stm->bind_param("sssd",$isbn,$author,$title,$price);
    $stm->execute();
    echo $stm->affected_rows." books insert into books";
    $stm->close();
    ?>
</body>
</html>