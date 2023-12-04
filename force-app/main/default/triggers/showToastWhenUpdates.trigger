
trigger showToastWhenUpdates on LegalAdvisors__c (after insert, after update) {
         else if (Trigger.isAfter) {
            if (Trigger.isInsert || Trigger.isUpdate) {
                // Your logic for ObjectB after insert/update
            }
        }
}

    


trigger showToastWhenUpdates on Client__c ( after insert, after update) {
     if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            // Your logic for ObjectB after insert/update
        }
    }
}