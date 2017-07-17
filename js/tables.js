// JavaScript Document
$(document).ready(function(){
	reSize();
	$(window).resize(function(){
		reSize();
	})
	
	function reSize(){
		var secWidth =  document.body.offsetWidth;
		var bHeight = $(window).height();
		var topHeight = 170;
		var asiWidth = 190;
		
		var secHeight = bHeight-topHeight;
		var maiWidth = secWidth - asiWidth;
		$('#main').css('width',maiWidth);
		$('#section').css('height',secHeight);
		$('.table-box').css('height',secHeight-75);
	}
	
	$(document).on('click','.home-nav li',function(){
		$(this).siblings().removeClass('li-cur');
		$(this).addClass('li-cur');
	});
	
	$(document).on('click','#li1',function(){
        console.log(user);

		$('.popup1').show();
	});
	$(document).on('click','#li2',function(){
		$('.popup2').show();
	});
	$(document).on('click','.mask',function(){
        $('.target-value-selecter').removeClass('target-value-selecter');
		$('.popup').hide();
	});
    $(document).on('click','.close-popup',function(){
        $('.target-value-selecter').removeClass('target-value-selecter');
        $('.popup').hide();
    });


	
});






