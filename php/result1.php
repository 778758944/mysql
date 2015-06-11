<?php
/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2015-02-28 13:42:42
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
    <h1>book-o-rama search result</h1>
    <?php
    $searchtype=$_POST["searchtype"];
    $searchterm=trim($_POST["searchterm"]);

    if(!$searchtype||!$searchterm){
    	echo "please enter data";
    	exit;
    }

    if(!get_magic_quotes_gpc()){
    	$searchtype=addslashes($searchtype);
    	$searchterm=addslashes($searchterm);
    }

    //建立数据库连接
    @$db=new mysqli("localhost","kk","123321q","books");

    //连接失败处理
    if(mysqli_connect_errno()){
    	echo "can not connect datebase";
    	exit;
    }

    //查询
    $query="select * from books where ".$searchtype." like '%".$searchterm."%'";
    $result=$db->query($query);

    $num_result=$result->num_rows;

    echo "<p>number of books found ".$num_result."</p>";
    for($i=0; $i<$num_result; $i++){
    	$row=$result->fetch_assoc();
    	echo "<p><strong>".($i+1)." title:";
    	echo htmlspecialchars(stripslashes($row["title"]));
    	echo "</strong><br/>Author: ";
    	echo stripslashes($row["author"]);
    	echo "<br/>isbn:";
    	echo stripslashes($row["isbn"]);
    	echo "<br/>price:";
    	echo stripslashes($row["price"]);
    	echo "</p>";
    };
    //释放结果
    $result->free();
    $db->close();


    ?>
</body>