package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.model.Preferences;

  import flash.display.StageDisplayState;

  import mx.managers.PopUpManager;

  public class ViewController
  {
    public var rootStage:BigVisibleCruise;
    public var preferences:Preferences;

    public function ViewController(rootStage:BigVisibleCruise=null, preferences:Preferences=null)
    {
      super();
      this.rootStage = rootStage;
      this.preferences = preferences;
    }

    public function switchFullScreen():void
    {
      preferences.fullScreen = !preferences.fullScreen;
      rootStage.stage.displayState = preferences.fullScreen ? StageDisplayState.FULL_SCREEN_INTERACTIVE:StageDisplayState.NORMAL;
    }

    public function showConfigurationScreen():void
    {
      var popup:ConfigurationWindow = PopUpManager.createPopUp(rootStage, ConfigurationWindow, true) as ConfigurationWindow;
      PopUpManager.centerPopUp(popup);
      popup.preferences = preferences;
    }
  }
}
