var ready, asInitVals = [];

ready = function() {
	oTable = $('#dt-faved').dataTable({
		bAutoWidth: false,
		aaSorting: [[0, 'asc']],
		aoColumns: [
			{ sWidth: "45%" },
			{ sWidth: "45%" },
			{ sWidth: "5%" },
		]
	});
	oTable.columnFilter({
		aoColumns: [
			{ type: "text" },
			{ type: "text" },
			null,
		]
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);