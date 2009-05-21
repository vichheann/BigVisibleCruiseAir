package com.piaction.dashboard.cruiseControl.model
{
  public class ProjectStatusEnum
  {
    public static const SUCCESS:ProjectStatusEnum = new ProjectStatusEnum("Success");
    public static const FAILURE:ProjectStatusEnum = new ProjectStatusEnum("Failure");
    public static const EXCEPTION:ProjectStatusEnum = new ProjectStatusEnum("Exception");
    public static const UNKNOWN:ProjectStatusEnum = new ProjectStatusEnum("Unknown");

    public static const values:Array = new Array(SUCCESS, FAILURE, EXCEPTION, UNKNOWN);

    private var _label:String;

    public function ProjectStatusEnum(label:String)
    {
      super();
      this._label = label;
    }

    public function get label():String
    {
      return _label;
    }

    public function equals(status:ProjectStatusEnum):Boolean
    {
      if (status == null)
        return false;
      return _label == status.label;
    }
  }
}
