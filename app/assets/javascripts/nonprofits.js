var ready, asInitVals = [];

ready = function() {
	oTable = $('#dt-employers').dataTable({
		bAutoWidth: false,
		aaSorting: [[1, 'desc']],
		aoColumns: [
			{bSortable: false, bSearchable: false, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
			{bSortable: true, bSearchable: true, sWidth: "30%"},
			{bSortable: true, bSearchable: true, sWidth: "30%"},
			{bSortable: true, bSearchable: true, sWidth: "5%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
			{bSortable: true, bSearchable: true, sWidth: "10%"},
		]
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