package com.piaction.dashboard.cruiseControl.model
{
  import flash.utils.Timer;

  [Bindable]
  public class Preferences
  {
    public var dashboardUrl:String;
    public var fullScreen:Boolean;

    public var refreshTimer:Timer = new Timer(30000);

    [Bindable("refreshIntervalChanged")]
    public function get refreshInterval():int
    {
      return refreshTimer.delay / 1000;
    }
    public function set refreshInterval(value:int):void
    {
      var restart:Boolean;
      if (refreshTimer.running)
      {
        refreshTimer.stop();
        restart = true;
      }
      refreshTimer.delay = value * 1000;
      if (restart)
      {
        refreshTimer.start();
      }
      dispatchEvent(new Event("refreshIntervalChanged"));
    }

    private static var _instance:Preferences = new Preferences();

    public static function getInstance():Preferences
    {
      return _instance;
    }
  }
}
