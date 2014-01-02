var ready, asInitVals = [];

ready = function() {
	dLength = parseInt($("#dLength").val(), 10);

	oTable = $("#dt-members").dataTable({
		bAutoWidth: false,
		aaSorting: [[0, 'asc']],
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		aoColumns: [
			{ sWidth: "40%" },
			{ sWidth: "40%" },
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
			{ type: "date-range" },
			{ type: "date-range" },
		]
	});

	tinyMCE.init({
    mode: 'textareas'
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);