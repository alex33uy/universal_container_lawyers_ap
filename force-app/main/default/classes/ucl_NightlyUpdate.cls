public  class ucl_NightlyUpdate implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        ucl_UpsertAdvisors.UpsertAdvisors();
        ucl_UpsertClients.UpsertClients();     
    }
}