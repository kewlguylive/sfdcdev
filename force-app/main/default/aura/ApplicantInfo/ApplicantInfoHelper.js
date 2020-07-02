({
	viewDocument : function(row) {
    $A.get('e.lightning:openFiles').fire({
        recordIds: [row.documentId]
    });                 
   }
})