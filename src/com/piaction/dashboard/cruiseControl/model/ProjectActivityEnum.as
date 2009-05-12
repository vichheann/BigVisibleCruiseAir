package com.piaction.dashboard.cruiseControl.model
{
  public class ProjectActivityEnum
  {
    public static const SLEEPING:ProjectActivityEnum = new ProjectActivityEnum("Sleeping");
    public static const BUILDING:ProjectActivityEnum = new ProjectActivityEnum("Building");
    public static const CHECKING_MODIFICATIONS:ProjectActivityEnum = new ProjectActivityEnum("CheckingModifications");

    public static const values:Array = new Array(SLEEPING, BUILDING, CHECKING_MODIFICATIONS);

    private var _label:String;

    public function ProjectActivityEnum(label:String)
    {
      super();
      this._label = label;
    }

    public function get label():String
    {
      return _label;
    }

    public function equals(activity:ProjectActivityEnum):Boolean
    {
      if (activity == null)
        return false;
      return _label == activity.label;
    }
  }
}
