package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.events.MessageEvent;
  import com.piaction.dashboard.cruiseControl.model.Preferences;

  import flash.display.StageDisplayState;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;

  import mx.managers.PopUpManager;

  public class ViewController
  {
    public var preferences:Preferences;
    private var _configurationPopup:ConfigurationWindow;

    public function ViewController(rootStage:BigVisibleCruise=null, preferences:Preferences=null)
    {
      super();
      this.rootStage = rootStage;
      this.preferences = preferences;
    }

    private var _rootStage:BigVisibleCruise;
    public function set rootStage(rootStage:BigVisibleCruise):void
    {
      _rootStage = rootStage;
      if (_rootStage != null)
      {
        _rootStage.stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
      }
    }

    public function get rootStage():BigVisibleCruise
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

    private function createPopUp():void
    {
      if (_configurationPopup == null)
      {
        _configurationPopup = PopUpManager.createPopUp(rootStage, ConfigurationWindow, true) as ConfigurationWindow;
      }
    }

    private function reportKeyDown(event:KeyboardEvent):void
    {
      if (event.commandKey || event.controlKey)
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
        _rootStage.checkSound();
      }
    }
  }
}
