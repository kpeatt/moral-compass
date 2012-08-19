<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>home page</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="assets/framework.css"/>
<link href="http://vjs.zencdn.net/c/video-js.css" rel="stylesheet">
    
	<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js"></script> 
	<script type="text/javascript" src="jquery.videoBG.js?ver=1.3.3"></script>
	<script type="text/javascript" src="assets/script.js?ver=1.3.3"></script>
    <script  type="text/javascript" src="js/jquery.js"></script> 
    <script src="http://vjs.zencdn.net/c/video.js?ver=1.3.3"></script>  
     
	<script type="text/javascript">
    var J = jQuery.noConflict();
    </script>	
	        
</head>
<body>


<div class="ipad_con">&nbsp;
    <div class="ipad">
        <div class="video">
        <video width="290" height="440" d autoplay="autoplay" loop="loop">
          <source src="MAP_VIEW_Custom.mp4" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'/ > 
          <source src="MAP_VIEW_Custom_1..webm" type='video/webm; codecs="vp8, vorbis"'/> 
          <source src="MAP_VIEW_Custom.ogv" type='video/ogg; codecs="theora, vorbis"'/> 
          <source src="MAP_VIEW_Custom_1.ogg" type="video/ogg" />
        </video>
        </div>
    </div>
</div>

<div class="form_con">&nbsp;
<div id="p_main_call">
	<div class="logo"><img src="images/logo.png" width="522" height="225" border="0" /></div>
    
    <div class="notified_con">

    	<label>Join the list to be notified when we launch.</label>
<script  type="text/javascript">
		J(document).ready(function(){
		 J("#contactboxtow").click(function(){
		  var valid = '';
		  var isr = ' is required.';
		
		  var email = J("#email").val();
		
		  
		  if (!email.match(/^([a-z0-9._-]+@[a-z0-9._-]+\.[a-z]{2,4}$)/i)) {
		   valid += '&nbsp;#&nbsp;A valid Email'+isr;
		  }
		
		  if (valid!='') {
		   J("#responsetow").fadeIn("slow");
		   J("#responsetow").html("Error:"+valid);
		  }
		  else {
		   var datastr ='email=' + email;
		   J("#responsetow").css("display", "block");
		   J("#responsetow").html("Sending message .... ");
		   J("#responsetow").fadeIn("slow");
		   J("#responsetow").show("slow")
		   setTimeout("emailsend('"+datastr+"')",2000);
		   
		  }
		  return false;
		 });
		 }); 
		function emailsend(datastr){
		 J.ajax({ 
		  type: "POST",
		  url: "/form.php",
		  data: datastr,
		  cache: false,
		  success: function(html){J("#responsetow").fadeIn("slow");
		  J("#responsetow").html(html);
		  setTimeout('J("#responsetow").fadeOut("slow")',1500);
		  document.forms['contactformTow'].reset();
		  if (document.getElementById) { 
		   document.getElementById('hidediv').style.display = 'none';
		   document.getElementById('showdiv').style.display = 'block';
		   }
		   else {
		   if (document.layers) { 
		   document.hidediv.display = 'none';
		   }
		   else { 
		   document.all.hidediv.style.display = 'none';
		   }
		   } 
		 }
		 });
		}    
    </script>        
        
        <form action="" method="POST" name="contactformTow" id="contactformTow">
        <div id="responsetow"></div>
          <div id="hidediv">
            	<div >
                <input id="email" name="email" type="text" value="" title="Email Address" class="notified fields" />
                </div>
                
                <div style="position:relative;">
	                <input type="submit" value="I’m Intrigued"  name="contactboxtow" id="contactboxtow" class="notified_button"  />
	                	<div id="select1" ></div>
	                	<div id="select2" ></div>
	                	<div id="select3" ></div>
	                	<div id="select4" ></div>
	                
	                	<div class="tTip" id="cloud1" title="I'm supposed to meet my friend at Aldo.<br>Now where is it?" onmouseover="_onMouseOver(1)" onmouseout="_onMouseOut(1)"></div>
		            	<div class="tTip" id="cloud2" title="Are there any deals today?" onmouseover="_onMouseOver(2)" onmouseout="_onMouseOut(2)"></div>
		            	<div class="tTip" id="cloud3" title="Who's hiring in the mall?" onmouseover="_onMouseOver(3)" onmouseout="_onMouseOut(3)"></div>
		            	<div class="tTip" id="cloud4" title="We'll have to ask someone. I don't know where it is." onmouseover="_onMouseOver(4)" onmouseout="_onMouseOut(4)"></div>
	        	    	<div class="tTip" id="cloud5" title="Mom! I need to go to the washroom!" onmouseover="_onMouseOver(5)" onmouseout="_onMouseOut(5)"></div>
		        	 
		        	<div id="cc4" class="tip1" style="left: 324px; top: -7px; display: none;position:absolute;">
					<div class="tipMid"><b>We'll have to ask someone. I don't know where it is.</b></div>
					<div class="tipBtm"></div>
				</div>	
		        	 <div id="cc5" class="tip1" style="left: 452px; top: 160px; display: none;position:absolute;">
					<div class="tipMid"><b>Mom! I need to go to the washroom!</b></div>
					<div class="tipBtm"></div>
				</div>  				
	               
                </div>
                <?php
                if (!empty($_GET['ref']))
                {
                    echo "<input type=\"hidden\" name=\"ref\" value=\"{$_GET['ref']}\" />";
                }
                ?>
</div>
            </form>
        
        <div id="showdiv" style="display:none">zxzxzxz</div>
        
    </div>
    <div class="like_con">
    	<ul>
        	<li><img src="images/facebooklike.png" width="148" height="30" border="0" /></li>
            <li><img src="images/follow.png" width="148" height="30" border="0" /></li>
        </ul>
    </div>
</div>
</div>

</body>
</html>
