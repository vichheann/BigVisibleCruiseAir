package com._2h2n_.dashboard.cruiseControl.model
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
      return lastStatusIsSuccess() && isSleeping();
    }

    public function hasFailed():Boolean
    {
      return (lastStatusIsFailure() || lastStatusIsException()) && isSleeping();
    }

    public function isSleeping():Boolean
    {
      return activity.equals(ProjectActivityEnum.SLEEPING);
    }

    public function isBuilding():Boolean
    {
      return activity.equals(ProjectActivityEnum.BUILDING);
    }

    public function isCheckingModifications():Boolean
    {
      return activity.equals(ProjectActivityEnum.CHECKING_MODIFICATIONS);
    }

    public function lastStatusIsSuccess():Boolean
    {
      return lastBuildStatus.equals(ProjectStatusEnum.SUCCESS);
    }

    public function lastStatusIsFailure():Boolean
    {
      return lastBuildStatus.equals(ProjectStatusEnum.FAILURE);
    }

    public function lastStatusIsException():Boolean
    {
      return lastBuildStatus.equals(ProjectStatusEnum.EXCEPTION);
    }

    public function lastStatusIsUnknown():Boolean
    {
      return lastBuildStatus.equals(ProjectStatusEnum.UNKNOWN);
    }
  }
}
