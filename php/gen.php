<?php
/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2015-02-28 15:16:26
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
    <h1>Book-O-Rama Search Results</h1>
    <?php
      $searchtype=$_POST['searchtype'];
      $searchterm=trim($_POST['searchterm']);

	  if (!$searchtype || !$searchterm) {
	     echo "You have not entered search details.  Please go back and try again.";
	     exit;
	  }

	  if (!get_magic_quotes_gpc()) {
	    $searchtype = addslashes($searchtype);
	    $searchterm = addslashes($searchterm);
	  }

	  require_once("MDB2.php");
	  $user="kk";
	  $pass="123321q";
	  $host="localhost";
	  $db_name="books";

	  $dsn="mysqli://".$user.":".$pass."@".$host.":".$db_name;
	  $db=&MDB2::connect($dsn);

	  if(MDB2::isError($db)){
	  	echo $db->getMessage();
	  	exit;
	  }

	  $query="select * from books where ".$searchtype." like '%".$searchterm."%'";
	  $result=$db->query($query);

	    $num_results = $result->numRows();

  // display each returned row
  for ($i=0; $i <$num_results; $i++) {
     $row = $result->fetchRow(MDB2_FETCHMODE_ASSOC);
     echo "<p><strong>".($i+1).". Title: ";
     echo htmlspecialchars(stripslashes($row['title']));
     echo "</strong><br />Author: ";
     echo stripslashes($row['author']);
     echo "<br />ISBN: ";
     echo stripslashes($row['isbn']);
     echo "<br />Price: ";
     echo stripslashes($row['price']);
     echo "</p>";
  }

  // disconnect from database
  $db->disconnect();


    ?>
</body>
</html>