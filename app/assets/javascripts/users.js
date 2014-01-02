var ready;

ready = function() {
	dLength = parseInt($("#dLength").val(), 10);

	oTable = $("#dt-users").dataTable({
		bAutoWidth: false,
		//Makes 2nd column default DESC
		aaSorting: [[1, 'desc']],
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		aoColumns: [
			{bSortable: false, bSearchable: false, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
			{bSortable: true, bSearchable: true, sWidth: "20%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "30%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
		],
		fnInitComplete: function() {
			/* auto change settings if it has fewer than 10 rows */
			var oListSettings = this.fnSettings();
			var wrapper = this.parent();

			if (oListSettings.fnRecordsTotal() < 10) {
				$('.dataTables_paginate', wrapper).hide();
				$('.dataTables_filter', wrapper).hide();
				$('.dataTables_info', wrapper).hide();
				$('.dataTables_length', wrapper).hide();
			}
		}
	});

	oTable.columnFilter({
		aoColumns: [
			null,
			{ type: "text" },
			{ type: "text" },
			{ type: "select" },
			{ type: "text" },
			{ type: "date-range" },
			{ type: "date-range" }
		]
	});

	bar = $("#bar");
	$('#password').keyup(function() {
		checkStrength($('#password').val());
	});

	function checkStrength(password) {
		var strength = 0;
		//over 7 chars, but cant be all alpha
		if (password.length > 7 && (password.match(/([0-9])/) || password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))) strength += 1;
		//upper and lowercase alpha
		if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1;
		//alpha and numeric
		if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1;
		//one special char
		if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1;
		//two special chars
    if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,",%,&,@,#,$,^,*,?,_,~])/)) strength += 1;
		function setBars(el,str,txt,bar) {
			if(bar) {
				el.parent().removeClass().addClass('progress '+bar).css({'width':'272px','height':'26px','margin-bottom':'-11px'});
			}
			el.css("width",str).text(txt);
		}
		//console.log(strength);
		if(strength === 0) {
			setBars(bar,"100%","easily hacked!","progress-danger progress-striped");
		} else if (strength == 1) {
			setBars(bar,"34%","weak", "progress-info");
		} else if (strength == 2) {
			setBars(bar,"50%","good", "progress-warning");
		} else if (strength == 3) {
			setBars(bar,"67%","better", "progress-warning");
		} else if (strength == 4) {
			setBars(bar,"84%","strong", "progress-success");
		} else if (strength == 5) {
			setBars(bar,"100%","excellent!", "progress-success");
		}
	}
};

$(document).ready(ready);
$(document).on('page:load', ready);