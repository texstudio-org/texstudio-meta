$(document).ready(function() {
	function filterPath(string) {
		return string
			.replace(/^\//,'')	
			.replace(/(index|default).[a-zA-Z]{3,4}$/,'')
			.replace(/\/$/,'');
	}
	
	/*** smooth scrolling ***/
	$('a[href*=#]').each(function() {
		if ( filterPath(location.pathname) == filterPath(this.pathname)
		&& location.hostname == this.hostname
		&& this.hash.replace(/#/,'') ) {
			var $targetId = $(this.hash), $targetAnchor = $('[name=' + this.hash.slice(1) +']');
			var $target = $targetId.length ? $targetId : $targetAnchor.length ? $targetAnchor : false;
			if ($target) {
				var targetOffset = $target.offset().top - $target.css("margin-top").replace("px", "");
				$(this).click(function() {
					$('html, body').animate({scrollTop: targetOffset}, 500);
					return false;
				 });
			}
		}
	});

	/*** navgation highlighting ***/
	var div='html'
	var numNavitems = 6;
	var docTop=0;
	$('#navigation .nav1').addClass('menu_active');
	setInterval(updateNavLink,150);
	
	function updateNavLink(){
		newDocTop=$(div).attr('scrollTop');
		var fl=true;
		if ((newDocTop!=docTop)&&(fl)){
			docTop=newDocTop;
			for (var i=1; i<=numNavitems; i++) {
				elem=$('#navigation .nav'+i+' a').attr("href");
				if ($(elem).offset().top<=docTop+150) {
					$('#navigation li').removeClass('menu_active');
					$('#navigation .nav'+i).addClass('menu_active');
				} else {
					break;
				}
			}
		}
	}
});
