package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.model.Preferences;

  import flash.display.StageDisplayState;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;

  import mx.controls.Alert;
  import mx.core.Application;
  import mx.managers.PopUpManager;
  import mx.rpc.Fault;

  public class ViewController
  {
    public var preferences:Preferences;
    public var main:MainComponent;
    private var _configurationPopup:ConfigurationWindow;

    public function ViewController(rootStage:BigVisibleCruise=null, main:MainComponent=null, preferences:Preferences=null)
    {
      super();
      this.rootStage = rootStage;
      this.main = main;
      this.preferences = preferences;
    }

    private var _rootStage:Application;
    public function set rootStage(rootStage:Application):void
    {
      _rootStage = rootStage;
      if (_rootStage != null)
      {
        _rootStage.stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
      }
    }

    public function get rootStage():Application
    {
      return _rootStage;
    }

    public function switchFullScreen():void
    {
      preferences.fullScreen = !preferences.fullScreen;
      rootStage.stage.displayState = preferences.fullScreen ? StageDisplayState.FULL_SCREEN_INTERACTIVE:StageDisplayState.NORMAL;
    }

    public function showConfigurationScreen():void
    {
      createPopUp();
      _configurationPopup.visible = true;
      _configurationPopup.preferences = preferences;
      PopUpManager.centerPopUp(_configurationPopup);
    }

    public function showError(fault:Fault):void
    {
      Alert.show(fault.message, "Problem");
    }

    private function createPopUp():void
    {
      if (_configurationPopup == null)
      {
        _configurationPopup = PopUpManager.createPopUp(rootStage, ConfigurationWindow, true) as ConfigurationWindow;
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
