<?php

/*-------------------------------------------------------*\
| ********* DO NOT REMOVE THIS COPYRIGHT NOTICE ********* |
+---------------------------------------------------------+
| Developed by:  Manni < manuel_mannhardt@web.de >        |
|                Dzoki < dzoki.travian@gmail.com >        |
| Copyright:     TravianX Project All rights reserved     |
\*-------------------------------------------------------*/

	if ( isset($_POST['name'])) {
		mysql_query("UPDATE ".TB_PREFIX."hero SET `name`='".($_POST['name'])."' where `uid`='".$session->uid."'") or die("ERROR:".mysql_error());
		$hero = mysql_query("SELECT * FROM " . TB_PREFIX . "hero WHERE `uid` = " . $session->uid . "");
		$hero_info = mysql_fetch_array($hero);
		echo "Heros name has been changed";
	}

	$hero = $units->Hero($session->uid);
	$h_attack = $hero['atk'];
	$hero['di'] = $hero['di'];
	$hero['dc'] = $hero['dc'];

//	$h_attack = ${'h'.$hero_info['unit']}['atk'] + 5 * floor($hero_info['attack'] * ${'h'.$hero_info['unit']}['atkp']/ 5);      
//	$hero['di'] = ${'h'.$hero_info['unit']}['di'] + 5 * floor($hero_info['defence'] * ${'h'.$hero_info['unit']}['dip']/ 5);      
//	$hero['dc'] = ${'h'.$hero_info['unit']}['dc'] + 5 * floor($hero_info['defence'] * ${'h'.$hero_info['unit']}['dcp']/ 5);      
        
?>
    <table id="distribution" cellpadding="1" cellspacing="1">
	<thead><tr>
		<th colspan="5"><?php 
        
        if(isset($_GET['rename'])){
            echo "<form action=\"\" method=\"POST\"><input type=\"hidden\" name=\"userid\" value=\"".$session->uid."\"><input type=\"hidden\" name=\"hero\" value=\"1\"><input type=\"text\" class=\"text\" name=\"name\" maxlength=\"20\" value=\"".$hero_info['name']."\">";            
        }else{
            echo "<a href=\"build.php?id=".$id."&rename\">".$hero_info['name']."</a></form>";
        }
        
        ?> Level <?php echo $hero_info['level']; ?> <span class="info">(<?php echo $technology->getUnitName($hero_info['unit']); ?>)</span></th>
	</tr></thead>
	<tbody><tr>
		<th>Offence</th>
		<td class="val"><?php echo $h_attack; ?></td>
		<td class="xp"><img class="bar" src="img/x.gif" style="width:<?php echo (2*$hero_info['attack'])+1; ?>px;" alt="<?php echo $h_attack; ?>" title="<?php echo $h_attack; ?>" /></td>
		<td class="up"><span class="none">
        <?php
        if($hero_info['points'] > 0){
            echo "<a href=\"build.php?id=".$id."&add=off\">(<b>+</b>)</a>";
        }else {
            echo "<span class=\"none\">(+)</span>";
        }
        ?>
        </td>
		<td class="po"><?php echo $hero_info['attack']; ?></td>
	</tr>
	<tr>
		<th>Defence</th>
		<td class="val"><?php echo $hero['di'] . "/" . $hero['dc']; ?></td>
		<td class="xp"><img class="bar" src="img/x.gif" style="width:<?php echo (2*$hero_info['defence'])+1; ?>px;" alt="<?php echo $hero['di'] . "/" . $hero['dc']; ?>"  title="<?php echo $hero['di'] . "/" . $hero['dc']; ?>" /></td>
		<td class="up"><span class="none">
        <?php
        if($hero_info['points'] > 0){
            echo "<a href=\"build.php?id=".$id."&add=deff\">(<b>+</b>)</a>";
        }else {
            echo "<span class=\"none\">(+)</span>";
        }
        ?>
        </td>
		<td class="po"><?php echo $hero_info['defence']; ?></td>
	</tr>
		<tr>
		<th>Off-Bonus</th>
		<td class="val"><?php echo ($hero_info['attackbonus'] * 0.2); ?>%</td>
		<td class="xp"><img class="bar" src="img/x.gif" style="width:<?php echo ($hero_info['attackbonus'] * 2)+1; ?>px;" alt="<?php echo ($hero_info['attackbonus'] * 0.2); ?>%" title="<?php echo ($hero_info['attackbonus'] * 0.2); ?>%" /></td>
		<td class="up"><span class="none">
        <?php
        if($hero_info['points'] > 0){
            echo "<a href=\"build.php?id=".$id."&add=obonus\">(<b>+</b>)</a>";
        }else {
            echo "<span class=\"none\">(+)</span>";
        }
        ?>
        </td>
		<td class="po"><?php echo $hero_info['attackbonus']; ?></td>
	</tr>
	<tr>
		<th>Def-Bonus</th>
		<td class="val"><?php echo ($hero_info['defencebonus'] * 0.2); ?>%</td>
		<td class="xp"><img class="bar" src="img/x.gif" style="width:<?php echo ($hero_info['defencebonus'] * 2)+1; ?>px;" alt="<?php echo ($hero_info['defencebonus'] * 0.2); ?>%" title="<?php echo ($hero_info['defencebonus'] * 0.2); ?>%" /></td>
		<td class="up"><span class="none">
        <?php
        if($hero_info['points'] > 0){
            echo "<a href=\"build.php?id=".$id."&add=dbonus\">(<b>+</b>)</a>";
        }else {
            echo "<span class=\"none\">(+)</span>";
        }
        ?>
        </td>
		<td class="po"><?php echo $hero_info['defencebonus']; ?></td>
	</tr>
	<tr>
		<th>Regeneration</th>
		<td class="val"><?php echo ($hero_info['autoregen'] + ($hero_info['regeneration']*15)); ?>/Day</td>
		<td class="xp"><img class="bar" src="img/x.gif" style="width:<?php echo ($hero_info['regeneration']*2)+1; ?>px;" alt="<?php echo ($hero_info['autoregen'] + ($hero_info['regeneration']*15)); ?>/Day" title="<?php echo ($hero_info['autoregen'] + ($hero_info['regeneration']*15)); ?>/Day" /></td>
		<td class="up"><span class="none">
        <?php
        if($hero_info['points'] > 0){
            echo "<a href=\"build.php?id=".$id."&add=reg\">(<b>+</b>)</a>";
        }else {
            echo "<span class=\"none\">(+)</span>";
        }
        ?>
        </td>
		<td class="po"><?php echo $hero_info['regeneration']; ?></td>
	</tr>
	<tr>
		<td colspan="5" class="empty"></td>
	</tr>
	<tr>
		<th title="until the next level">Experience:</th>
		<td class="val">0%</td>
		<td class="xp"><img class="bar" src="img/x.gif" style="width:1px;" alt="0%" title="0%" /></td>
		<td class="up"></td>
		<td class="rem"><?php echo $hero_info['points']; ?></td>
	</tr>
	</tbody>
</table>

    <?php if(isset($_GET['e'])){
        echo "<p><font size=\"1\" color=\"red\"><b>Error: name too short</b></font></p>";
    }
    ?>
    <?php if($hero_info['level'] <= 3){ ?>
        <p>You can <a href="build.php?id=<?php echo $id; ?>&add=reset">reset</a> your points until you are level <b>3</b> or lower!</p>
    <?php } ?>
    <p>Your hero has <b><?php echo $hero_info['health']; ?></b>% of his hit points.<br/>
    Your hero has conquered <b>0</b> <a href="build.php?id=<?php echo $id; ?>&land">oases</a>.</p>
    
    
    
    <?php 
    
    if(isset($_GET['add'])) {
        	if($_GET['add'] == "reset") {
        		if($hero_info['level'] <= 3){
  		            if($hero_info['attack'] != 0 OR $hero_info['defence'] != 0 OR $hero_info['attackbonus'] != 0 OR $hero_info['defencebonus'] != 0 OR $hero_info['regeneration'] != 0){
                    mysql_query("UPDATE " . TB_PREFIX . "hero SET `points` = '".(($hero_info['level']*5)+10)."' WHERE `uid` = '" . $session->uid . "'");
                    mysql_query("UPDATE " . TB_PREFIX . "hero SET `attack` = '0' WHERE `uid` = '" . $session->uid . "'");
        			mysql_query("UPDATE " . TB_PREFIX . "hero SET `defence` = '0' WHERE `uid` = '" . $session->uid . "'");
        			mysql_query("UPDATE " . TB_PREFIX . "hero SET `attackbonus` = '0' WHERE `uid` = '" . $session->uid . "'");
        			mysql_query("UPDATE " . TB_PREFIX . "hero SET `defencebonus` = '0' WHERE `uid` = '" . $session->uid . "'");
        			mysql_query("UPDATE " . TB_PREFIX . "hero SET `regeneration` = '0' WHERE `uid` = '" . $session->uid . "'");
                    header("Location: build.php?id=".$id."");
        		}
        	}
         }
        	if($_GET['add'] == "off") {
        			if($hero_info['points'] > 0) {
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `attack` = `attack` + 1 WHERE `uid` = '" . $session->uid . "'");
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `points` = `points` - 1 WHERE `uid` = '" . $session->uid . "'");
                        header("Location: build.php?id=".$id."");
        			}
        		}
            if($_GET['add'] == "deff") {
        			if($hero_info['points'] > 0) {
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `defence` = `defence` + 1 WHERE `uid` = '" . $session->uid . "'");
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `points` = `points` - 1 WHERE `uid` = '" . $session->uid . "'");
                        header("Location: build.php?id=".$id."");
        			}
        		}
          if($_GET['add'] == "obonus") {
        			if($hero_info['points'] > 0) {
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `attackbonus` = `attackbonus` + 1 WHERE `uid` = '" . $session->uid . "'");
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `points` = `points` - 1 WHERE `uid` = '" . $session->uid . "'");
                        header("Location: build.php?id=".$id."");
        			}
        		}
          if($_GET['add'] == "dbonus") {
        			if($hero_info['points'] > 0) {
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `defencebonus` = `defencebonus` + 1 WHERE `uid` = '" . $session->uid . "'");
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `points` = `points` - 1 WHERE `uid` = '" . $session->uid . "'");
                        header("Location: build.php?id=".$id."");
        			}
        		}
          if($_GET['add'] == "reg") {
        			if($hero_info['points'] > 0) {
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `regeneration` = `regeneration` + 1 WHERE `uid` = '" . $session->uid . "'");
        				mysql_query("UPDATE " . TB_PREFIX . "hero SET `points` = `points` - 1 WHERE `uid` = '" . $session->uid . "'");
                        header("Location: build.php?id=".$id."");
        			}
        		}
          }
          
         ?>
