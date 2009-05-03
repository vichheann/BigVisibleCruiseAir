package com.piaction.dashboard.cruiseControl.model
{
  [Bindable]
  public class Preferences
  {
    public var dashboardUrl:String;
    public var fullScreen:Boolean;

    private static var _instance:Preferences = new Preferences();

    public static function getInstance():Preferences
    {
      return _instance;
    }
  }
}
