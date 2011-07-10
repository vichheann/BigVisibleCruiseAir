package com._2h2n_.dashboard.cruiseControl.events
{
  import flash.events.Event;

  public class MessageEvent extends Event
  {
    public static const LOAD_DATA:String = "loadData";
    public static const FULLSCREEN:String = "fullScreen";
    public static const SHOW_CONFIGURATION:String = "showConfiguration";
    public static const REFRESH:String = "refresh";

    public function MessageEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
    {
      super(type, bubbles, cancelable);
    }

  }
}
