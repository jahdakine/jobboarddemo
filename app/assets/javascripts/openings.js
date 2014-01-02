var ready, asInitVals = [];

ready = function() {
  $("#opening_date_open" ).datepicker({
		showButtonPanel: true
  });

  $("#opening_date_closed").datepicker({
		showButtonPanel: true,
    minDate: $("#opening_date_open").datepicker("getDate")
  });

	dLength = parseInt($("#dLength").val(), 10);

	oTable = $("#dt-openings-grad").dataTable({
		bAutoWidth: false,
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		//Makes 1st column default ASC
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ sWidth: "35%" },
			{ sWidth: "10%" },
			{ sWidth: "10%" },
			{ sWidth: "25%" },
			{ sWidth: "10%" },
			{ sWidth: "10%" },
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
			{ type: "text" },
			{ type: "text" },
			{ type: "select" },
			{ type: "text" },
			{ type: "date-range" },
			{ type: "date-range" },
		]
	});

	pTable = $('#dt-openings').dataTable({
		bAutoWidth: false,
		aaSorting: [[1, 'desc']],
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		aoColumns: [
			{ bSortable: false, bSearchable: false, sWidth: "10%" },
			{ bSortable: true, bSearchable: true, sWidth: "5%" },
			{ bSortable: true, bSearchable: true, sWidth: "10%" },
			{ bSortable: true, bSearchable: true, sWidth: "50%" },
			{ bSortable: true, bSearchable: true, sWidth: "10%" },
			{ bSortable: true, bSearchable: true, sWidth: "10%" },
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

	pTable.columnFilter({
		aoColumns: [
			null,
			{type: "text"},
			{type: "select"},
			{type: "text"},
			{type: "date-range"},
			{type: "date-range"}
		]
	});

	tinyMCE.init({
    mode: 'textareas'
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);