package com.piaction.dashboard.cruiseControl.model
{
  import com.asfusion.mate.events.Dispatcher;
  import com.piaction.dashboard.cruiseControl.events.MessageEvent;

  import flash.events.TimerEvent;
  import flash.utils.Timer;

  [Bindable]
  public class Preferences
  {
    public var dashboardUrl:String;
    public var fullScreen:Boolean;
    public var dispatcher:Dispatcher = new Dispatcher();

    private var _refreshTimer:Timer;

    public function Preferences(dashboardUrl:String = "", fullScreen:Boolean = false, refreshInterval:int = 30000):void
    {
      this.dashboardUrl = dashboardUrl;
      this.fullScreen = fullScreen;
      _refreshTimer = new Timer(refreshInterval);
      _refreshTimer.addEventListener(TimerEvent.TIMER, dispatchRefresh, false, 0, true);
      _refreshTimer.start();
    }

    [Bindable("refreshIntervalChanged")]
    public function get refreshInterval():int
    {
      return _refreshTimer.delay / 1000;
    }
    public function set refreshInterval(value:int):void
    {
      var restart:Boolean;
      if (_refreshTimer.running)
      {
        _refreshTimer.stop();
        restart = true;
      }
      _refreshTimer.delay = value * 1000;
      if (restart)
      {
        _refreshTimer.start();
      }
      dispatchEvent(new Event("refreshIntervalChanged"));
    }

    public function dispatchRefresh(event:TimerEvent=null):void
    {
      if (dashboardUrl != null && dashboardUrl.length > 0)
        dispatcher.dispatchEvent(new MessageEvent(MessageEvent.REFRESH, true));
    }
  }
}
