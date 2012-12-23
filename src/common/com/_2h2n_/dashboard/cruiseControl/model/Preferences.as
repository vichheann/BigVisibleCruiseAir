/*
 * Copyright 2011 Vichheann Saing (vichheann at gmail dot com)
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com._2h2n_.dashboard.cruiseControl.model
{
  import com.asfusion.mate.events.Dispatcher;
  import com._2h2n_.dashboard.cruiseControl.events.MessageEvent;

  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  [Bindable]
  public class Preferences
  {
    public var dashboardUrl:String;
    public var fullScreen:Boolean;
    public var dispatcher:Dispatcher = new Dispatcher();

    private var _refreshTimer:Timer;
    public var defaultColor:Object = {'success': ColorEnum.GREEN, 'failureDark': ColorEnum.RED, 'failureLight': ColorEnum.RED_LIGHT, 'building': ColorEnum.YELLOW, 'checking': ColorEnum.ORANGE, 'unknown': ColorEnum.WHITE};

    public var userColor:Object = cloneObject(defaultColor);

    public function Preferences(dashboardUrl:String = "", fullScreen:Boolean = false, refreshInterval:int = 60000):void
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
      dispatcher.dispatchEvent(new Event("refreshIntervalChanged"));
    }

    public function dispatchRefresh(event:TimerEvent=null):void
    {
      if (dashboardUrl != null && dashboardUrl.length > 0)
        dispatcher.dispatchEvent(new MessageEvent(MessageEvent.REFRESH, true));
    }

    public function resetToDefaultColors():Object
    {
      return cloneObject(defaultColor);
    }

    public function cloneUserColor():Object
    {
      return cloneObject(userColor);
    }

    public function setUserColor(colors:Object):void
    {
      userColor = cloneObject(colors);
    }

    private function cloneObject(color:Object):Object
    {
      var result:Object= new Object();
      for (var i:String in color)
      {
        result[i] = color[i];
      }
      return result;
    }

    public function getBackgroundColor(project:Project):ColorEnum
    {
      if (project.isSuccessful())
      {
        return userColor['success'];
      }
      if (project.hasFailed())
      {
        return userColor['failureDark'];
      }
      if (project.isBuilding())
      {
        return userColor['building'];
      }
      if (project.isCheckingModifications())
      {
        return userColor['checking'];
      }
      if (project.isSleeping() && project.lastStatusIsUnknown())
      {
        return userColor['unknown'];
      }
      return ColorEnum.BLACK;
    }
  }
}
