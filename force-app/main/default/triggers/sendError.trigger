trigger handleUpdate on Error_Log__c (after insert) {
    for(Error_Log__c err : Trigger.new) {
        
    if (Trigger.isInsert) {
        Messaging.SingleEmailMessasge .sendMail('aporcal13@gmail.com', 'Universal Lawyers Container', 
                    Error_Log__c + ' contact(s) were inserted.');
    }
    }
}