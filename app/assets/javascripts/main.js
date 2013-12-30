var ready;

ready = function() {

	$('a.dialog').click(function() {
		var url = this.href;
		// show a spinner or something via css
		var aDialog = $('<div style="display:none" class="loading"></div>').appendTo('body');
		// open the dialog
		aDialog.dialog({
			// add a close listener to prevent adding multiple divs to the document
			close: function(event, ui) {
			// remove div with all data and events
			dialog.remove();
			},
			modal: true,
			width: '75%',
			height: 600,
			position: ['top', 125],
			dialogClass: "no-close",
			buttons: [{
				text: "Close",
				click: function() {
					$( this ).dialog( "close" );
				}
			}]
		});
		// load remote content
		aDialog.load(
			url,
			//{}, // omit this param object to issue a GET request instead a POST request, otherwise you may provide post parameters within the object
			function (responseText, textStatus, XMLHttpRequest) {
			// remove the loading class
				aDialog.removeClass('loading');
			});
		//prevent the browser to follow the link
		return false;
	});
	$("#category").on('click', function() {
		swapClass($("#categories"),'cat');
	});
	$("#type").on('click', function() {
		alert("Not yet implemented");
		swapClass($("#types"),'type');
	});
	$("#location").on('click', function() {
		alert("Not yet implemented");
		swapClass($("#locations"),'loc');
	});
	function swapClass(elem, name) {
		switch (name) {
			case 'cat':
				icon = $("#job-cat-icon");
				break;
			case 'type':
				icon = $("#job-type-icon");
				break;
			case 'loc':
				icon = $("#job-loc-icon");
				break;
		}
		if (elem.is(":visible")) {
			elem.hide();
			icon.removeClass("icon-chevron-up").addClass("icon-chevron-down");
		} else {
			elem.show();
			icon.removeClass("icon-chevron-down").addClass("icon-chevron-up");
		}
	}
};

$(document).ready(ready);
$(document).on('page:load', ready);