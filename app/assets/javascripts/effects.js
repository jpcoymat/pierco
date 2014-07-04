$(document).ready(function() {

	$('.ie7 .ask label').append('<span> *</span>')

//main slide
	$(".wheels-showcase").carouFredSel({
		items: 5,
		auto: false,
		scroll: 1500,
		auto: 5000,
		prev: ".prev",
		next: ".next"
	});

$('.nav-content').hide();
$('.open').parent('li').children('.nav-content').slideToggle();
//accordeon for side menu
	$('.accordion').click(function(event){
		event.preventDefault();
		if($(this).hasClass('open')){
				$(this).parent('li').children('.nav-content').slideToggle();
					$(this).toggleClass('open');
		}else{
			$('.open').parent('li').children('.nav-content').slideToggle();
			$('.open').toggleClass("open");
			$(this).parent('li').children('.nav-content').slideToggle();
			$(this).toggleClass('open');
		}
	});
});
