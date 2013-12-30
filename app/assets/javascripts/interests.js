var ready, asInitVals = [];

ready = function() {
	oTable = $("#dt-interests").dataTable({
		bAutoWidth: false,
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
		aoColumns: [
			{ type: "text" }
		]
	});

	$("#dt-categories-openings").dataTable().columnFilter({
		//Makes 1st column default ASC
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ type: "text" }
		]
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);