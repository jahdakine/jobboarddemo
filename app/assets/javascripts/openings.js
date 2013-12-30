var ready, asInitVals = [];

ready = function() {
  $("#opening_date_open" ).datepicker({
		showButtonPanel: true
  });
  
  $("#opening_date_closed").datepicker({
		showButtonPanel: true,
    minDate: $("#opening_date_open").datepicker("getDate")
  });
	
	oTable = $("#dt-openings-grad").dataTable({
		bAutoWidth: false,
		//Makes 1st column default ASC
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ sWidth: "35%" },
			{ sWidth: "10%" },
			{ sWidth: "10%" },
			{ sWidth: "25%" },
			{ sWidth: "10%" },
			{ sWidth: "10%" },
		]
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
		aoColumns: [
			{ bSortable: false, bSearchable: false, sWidth: "10%" },
			{ bSortable: true, bSearchable: true, sWidth: "5%" },
			{ bSortable: true, bSearchable: true, sWidth: "10%" },
			{ bSortable: true, bSearchable: true, sWidth: "50%" },
			{ bSortable: true, bSearchable: true, sWidth: "10%" },
			{ bSortable: true, bSearchable: true, sWidth: "10%" },
		]
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