public class AnnouncementQueueable implements Queueable{
  public List<ConnectApi.AnnouncementInput> toPost1;
  // Modify this class to implement the Queueable interface 
  public void execute(QueueableContext context){
    PostAnnouncements(toPost1);
  }
  public static void PostAnnouncements(List<ConnectApi.AnnouncementInput> announcements){
    while(announcements.size() > 0) {
      if (Limits.getDMLStatements() < Limits.getLimitDMLStatements() && !Test.isRunningTest()) {
        ConnectApi.AnnouncementInput anmt = announcements.remove(0);
        ConnectApi.Announcements.postAnnouncement('Internal', anmt);
      } else {break;}
    }
    if (announcements.size() > 0 && !Test.isRunningTest()) {
      AnnouncementQueueable q = new AnnouncementQueueable();
      q.toPost1 = announcements; System.enqueueJob(q);
    }
  }
}