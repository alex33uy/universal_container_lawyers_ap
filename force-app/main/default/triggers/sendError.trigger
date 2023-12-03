trigger handleUpdate on Error_Log__c (after insert) {
    for(Error_Log__c err : Trigger.new) {
        
    if (Trigger.isInsert) {
        Integer recordCount = Trigger.new.size();
        EmailManager.sendMail('aporcal13@gmail.com', 'Universal Lawyers Container', 
                    recordCount + ' contact(s) were inserted.');
    }
    }
}