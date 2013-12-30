var ready, asInitVals = [];

ready = function() {
	oTable = $('#dt-saved').dataTable({
		bAutoWidth: false,
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ sWidth: "30%" },
			{ sWidth: "10%" },
			{ sWidth: "10%" },
			{ sWidth: "30%" },
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
			{ type: "date-range" }
		]
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);