@isTest
public class WarehouseSyncScheduleTest {
    @isTest
    static void testWHSchedule() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());   		
        String CRON_EXP =  '0 0 0 3 8 ? 2021';
        Test.startTest();
        
        String jobId = System.schedule('testWareHouseSchedule', CRON_EXP, new WarehouseSyncSchedule());
        
        Test.stopTest();
        
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                          NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals(CRON_EXP,ct.CronExpression);
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
    }
}