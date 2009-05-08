package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.model.Preferences;

  import flash.display.StageDisplayState;

  import mx.managers.PopUpManager;

  public class Stage
  {
    public function Stage()
    {
      super();
    }

    public function switchFullScreen(rootStage:BigVisibleCruise):void
    {
      var preferences:Preferences = Preferences.getInstance();
      preferences.fullScreen = !preferences.fullScreen;
      rootStage.stage.displayState = preferences.fullScreen ? StageDisplayState.FULL_SCREEN_INTERACTIVE:StageDisplayState.NORMAL;
    }

    public function showConfigurationScreen(rootStage:BigVisibleCruise):void
    {
      var preferences:Preferences = Preferences.getInstance();
      var popup:ConfigurationWindow = PopUpManager.createPopUp(rootStage, ConfigurationWindow, true) as ConfigurationWindow;
      PopUpManager.centerPopUp(popup);
      popup.url = preferences.dashboardUrl;
      popup.refreshInterval = preferences.refreshInterval;
    }
  }
}
