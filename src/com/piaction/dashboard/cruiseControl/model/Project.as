package com.piaction.dashboard.cruiseControl.model
{
  import com.adobe.utils.DateUtil;

  [Bindable]
  public class Project
  {
    public var name:String;
    public var activity:ProjectActivityEnum;
    public var lastBuildStatus:ProjectStatusEnum;
    public var lastBuildLabel:String;
    public var lastBuildTime:Date;
    public var url:String;

    public function Project(name:String, activity:String, lastBuildStatus:String, lastBuildLabel:String, lastBuildTime:String, url:String)
    {
      this.name = name;
      this.activity = new ProjectActivityEnum(activity);
      this.lastBuildStatus = new ProjectStatusEnum(lastBuildStatus);
      this.lastBuildLabel = lastBuildLabel;
      this.lastBuildTime = isoToDate(lastBuildTime);
      this.url = url;
    }

    private function isoToDate(value:String):Date
    {
      var dateStr:String = value;
      dateStr = dateStr.replace(/-/g, "/");
      dateStr = dateStr.replace("T", " ");
      return new Date(Date.parse(dateStr));
    }

    public function isSuccessful():Boolean
    {
      return lastBuildStatus.equals(ProjectStatusEnum.SUCCESS) && activity.equals(ProjectActivityEnum.SLEEPING);
    }

    public function hasFailed():Boolean
    {
      return lastBuildStatus.equals(ProjectStatusEnum.FAILURE) && activity.equals(ProjectActivityEnum.SLEEPING);
    }
  }
}
