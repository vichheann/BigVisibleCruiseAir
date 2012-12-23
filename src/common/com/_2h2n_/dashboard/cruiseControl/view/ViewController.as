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

package com._2h2n_.dashboard.cruiseControl.view
{
  import com._2h2n_.dashboard.cruiseControl.model.Preferences;

  import flash.display.StageDisplayState;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;

  import mx.core.Application;
  import mx.managers.PopUpManager;
  import mx.rpc.Fault;

  public class ViewController
  {
    public var preferences:Preferences;
    private var main:MainComponent;
    private var _configurationPopup:ConfigurationWindow;

    public function ViewController(rootStage:BigVisibleCruise=null, preferences:Preferences=null)
    {
      super();
      this.preferences = preferences;
      this.rootStage = rootStage;
    }

    private var _rootStage:Application;
    public function set rootStage(rootStage:Application):void
    {
      _rootStage = rootStage;
      if (_rootStage != null)
      {
        _rootStage.stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
        this.main = (_rootStage as BigVisibleCruise).main;
      }
    }

    public function get rootStage():Application
    {
      return _rootStage;
    }

    public function switchFullScreen():void
    {
      if (!preferences.fullScreen)
      {
        preferences.fullScreen = !preferences.fullScreen;
        rootStage.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
      }
    }

    public function showConfigurationScreen(message:String = null):void
    {
      switchFullScreen();
      createPopUp();
      _configurationPopup.preferences = preferences;
      _configurationPopup.message = message;
      _configurationPopup.visible = true;
      PopUpManager.centerPopUp(_configurationPopup);
    }

    public function showError(fault:Fault):void
    {
      var message:String;
      switch (fault.faultCode)
      {
        case "Client.URLRequired":
          message = "You must provide an URL";
          break;
        case "Server.Error.Request":
          message = "You set a bad URL";
          break;
        default:
          message = fault.message;
          break;
      }
      showConfigurationScreen(message);
    }

    public function closePopUp():void
    {
      if (_configurationPopup && _configurationPopup.visible)
      {
        _configurationPopup.close();
      }
    }

    private function createPopUp():void
    {
      if (_configurationPopup == null)
      {
        _configurationPopup = PopUpManager.createPopUp(main, ConfigurationWindow, true) as ConfigurationWindow;
      }
    }

    private function reportKeyDown(event:KeyboardEvent):void
    {
      var controlKeyPressed:Boolean = event.hasOwnProperty("commandKey") ? (event.commandKey || event.controlKey) : event.ctrlKey;
      if (controlKeyPressed)
      {
        if (event.keyCode == Keyboard.R)
        {
          preferences.dispatchRefresh();
        }
        else if (event.keyCode == Keyboard.F)
        {
          switchFullScreen();
        }
        else if (event.keyCode == Keyboard.COMMA)
        {
          createPopUp();
          if (!_configurationPopup.visible)
          {
            showConfigurationScreen();
          }
        }
      }
      else if (event.shiftKey && event.keyCode == Keyboard.S)
      {
        main.checkSound();
      }
    }
  }
}
