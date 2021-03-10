$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
            case 'show':
                console.log('show')
				$('#main').removeClass("hide")
				break
            case 'hide':
                console.log('hide')
				$('#main').addClass("hide")
                break
		}
	})
})

$(document).ready(function () {

    $(document).keydown(respondKeypress)
    $('#main').keydown(respondKeypress)
    
})

function respondKeypress(event) {
    if (event.keyCode == 27 || event.keyCode == 36) { // ESCAPE / HOME
        console.log('Close');
        $.post("https://TitaniumCAD/hide", null)
    }
}