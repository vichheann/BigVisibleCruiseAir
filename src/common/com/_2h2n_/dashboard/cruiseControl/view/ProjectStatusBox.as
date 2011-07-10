package com._2h2n_.dashboard.cruiseControl.view
{
  import com._2h2n_.dashboard.cruiseControl.model.ColorEnum;
  import com._2h2n_.dashboard.cruiseControl.model.Preferences;
  import com._2h2n_.dashboard.cruiseControl.model.Project;

  import flash.display.Graphics;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  import mx.containers.Box;

  public class ProjectStatusBox extends Box
  {
    private var _textField:AutoFitUITextField;
    private var _blinkTimer:Timer;
    private var _backgroundColor:ColorEnum;

    private var _projectChanged:Boolean = false;
    private var _preferencesChanged:Boolean = false;

    public function ProjectStatusBox()
    {
      super();
      _blinkTimer = new Timer(800);
      _blinkTimer.addEventListener(TimerEvent.TIMER, toggleColor, false, 0, true);
    }

    [Bindable]
    public var preferences:Preferences;

    private var _project:Project;
    [Bindable("projectChanged")]
    public function get project():Project
    {
      return _project;
    }
    public function set project(value:Project):void
    {
      _project = value;
      _projectChanged = true;
      invalidateProperties();
      dispatchEvent(new Event("projectChanged"));
    }

    override protected function createChildren():void
    {
      super.createChildren();
      if (_textField == null)
      {
        _textField = new AutoFitUITextField();
        _textField.percentHeight = 100;
        addChild(_textField);
      }
    }

    override protected function commitProperties():void
    {
      if (_projectChanged && preferences)
      {
        _textField.text = project.name;
        if (_project.hasFailed())
        {
          _blinkTimer.start();
        }
        else if (_blinkTimer.running)
        {
          _blinkTimer.stop();
        }
        _projectChanged = false;
      }
    }

    override protected function measure():void
    {
      super.measure();
    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);
      if (_textField.text.length > 0)
      {
        _textField.fitText(unscaledWidth, unscaledHeight);
      }
      if (preferences)
        drawBackground(preferences.getBackgroundColor(_project));
    }

    private function drawBackground(color:ColorEnum):void
    {
      var h:Number = height;
      var g:Graphics = this.graphics;
      _backgroundColor = color;
      g.clear();
      g.beginFill(_backgroundColor.code);
      g.drawRect(0, 0, width, h);
      g.endFill();
    }

    private function toggleColor(event:TimerEvent):void
    {
      var newColor:ColorEnum = ColorEnum.WHITE;
      _backgroundColor.equals(preferences.userColor.failureDark) ? newColor = preferences.userColor.failureLight : newColor = preferences.userColor.failureDark;
      drawBackground(newColor);
    }
  }
}
