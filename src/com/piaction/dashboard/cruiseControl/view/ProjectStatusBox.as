package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.model.ColorEnum;
  import com.piaction.dashboard.cruiseControl.model.Project;
  import com.piaction.dashboard.cruiseControl.model.ProjectActivityEnum;
  import com.piaction.dashboard.cruiseControl.model.ProjectStatusEnum;

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

    public function ProjectStatusBox()
    {
      super();
      _blinkTimer = new Timer(800);
      _blinkTimer.addEventListener(TimerEvent.TIMER, toggleColor, false, 0, true);
    }

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
        addChild(_textField);
      }
    }

    override protected function commitProperties():void
    {
      if (_projectChanged)
      {
        _textField.text = project.name;
        var color:ColorEnum = getBackgroundColor(project);
        if (color.equals(ColorEnum.RED))
        {
          _blinkTimer.start();
        }
        else if (_blinkTimer.running)
        {
          _blinkTimer.stop();
        }
        _projectChanged = false;
        invalidateDisplayList();
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
        _textField.width = width;
        _textField.fitText(1, true, getExplicitOrMeasuredWidth());
        _textField.move(0, (height - _textField.height) / 2);
        height = _textField.getExplicitOrMeasuredHeight();
      }
      drawBackground(getBackgroundColor(_project));
    }

    private function getBackgroundColor(project:Project):ColorEnum
    {
      if (project.isSuccessful())
      {
        return ColorEnum.GREEN;
      }
      if (project.hasFailed())
      {
        return ColorEnum.RED;
      }
      if (project.isBuilding())
      {
        return ColorEnum.YELLOW;
      }
      if (project.isCheckingModifications())
      {
        return ColorEnum.ORANGE;
      }
      if (project.isSleeping() && project.lastStatusIsUnknown())
      {
        return ColorEnum.WHITE;
      }
      return ColorEnum.BLACK;
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
      _backgroundColor.equals(ColorEnum.RED) ? newColor = ColorEnum.RED_LIGHT : newColor = ColorEnum.RED;
      drawBackground(newColor);
    }
  }
}
