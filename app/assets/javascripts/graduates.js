var ready, asInitVals = [];

ready = function() {
	oTable = $("#dt-graduates").dataTable({
		bAutoWidth: false,
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ sWidth: "40%" },
			{ sWidth: "40%" },
			{ sWidth: "10%" },
			{ sWidth: "10%" },
		]
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