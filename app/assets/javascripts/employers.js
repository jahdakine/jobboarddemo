var ready, asInitVals = [];

ready = function() {
	dLength = parseInt($("#dLength").val(), 10);

	oTable = $('#dt-employers').dataTable({
		bAutoWidth: false,
		iDisplayLength: dLength,
		aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
		aaSorting: [[1, 'desc']],
		aoColumns: [
			{bSortable: false, bSearchable: false, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
			{bSortable: true, bSearchable: true, sWidth: "30%"},
			{bSortable: true, bSearchable: true, sWidth: "30%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
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
			{ type: "text" },
			null,
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