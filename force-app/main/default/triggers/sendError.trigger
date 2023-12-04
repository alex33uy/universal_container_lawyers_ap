trigger sendError on Error_Log__c (after insert) {
    for(Error_Log__c err : Trigger.new) {
        if (Trigger.isInsert) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        List<String> emailAddresses = new List<String>();
        string addresses = 'aporcal13@gmail.com';
        emailaddresses = addresses.split(':');
        message.ToAddresses = (emailAddresses);
        message.subject = 'congrats';
        message.plainTextBody = 'You have an error in your org';
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {message});
    }
    }
}