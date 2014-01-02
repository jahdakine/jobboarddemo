var ready, asInitVals = [];

ready = function() {
	dLength = parseInt($("#dLength").val(), 10);

	oTable = $("#dt-interests").dataTable({
		bAutoWidth: false,
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		//Makes 2nd column default ASC
		aaSorting: [[1, 'asc']],
		aoColumns: [
			//Removes sort and search from action (first) column
			{bSortable: false, bSearchable: false, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "60%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
		],
		fnInitComplete: function() {
			/* auto change settings if it has fewer than 25 rows */
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
			{ type: "select" },
			null,
			null,
			{ type: "date-range" },
			{ type: "date-range" },
		]
	});

	$("#dt-interest-users").dataTable().columnFilter({
		//Makes 1st column default ASC
		aaSorting: [[0, 'asc']],
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		aoColumns: [
			{ type: "text" }
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

	$("#dt-categories-openings").dataTable().columnFilter({
		//Makes 1st column default ASC
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ type: "text" }
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
};

$(document).ready(ready);
$(document).on('page:load', ready);