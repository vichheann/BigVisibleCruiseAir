package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.model.ColorEnum;
  import com.piaction.dashboard.cruiseControl.model.Project;

  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;

  import mx.core.UIComponent;

  public class ProjectStatusBox extends UIComponent
  {
    private var _textField:AutoFitTextField;
    private var _textLayout:Sprite;
    private var _blinkTimer:Timer;

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
        _textLayout = new Sprite();
        _textField = new AutoFitTextField(getDefaultTextFormat());
        _textField.changeAlign(TextFormatAlign. CENTER);
        _textLayout.addChild(_textField);
        addChild(_textField);
      }
    }

    override protected function commitProperties():void
    {
      if (_projectChanged)
      {
        _textField.text = project.name;
        var color:ColorEnum = getBackgroundColor(project);
        setStyle("backgroundColor", color.code);
        /*if (color == ColorEnum.RED)
        {
          _blinkTimer.start();
        }
        else if (_blinkTimer.running)
        {
          _blinkTimer.stop();
        }*/
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

      _textField.wordWrap = true;
      _textField.x = Number(getStyle("paddingLeft"));
      _textField.y = Number(getStyle("paddingTop"));
      //_textField.width = Number(getStyle("preferredWidth"));
      _textField.width = Math.max(getExplicitOrMeasuredWidth(), unscaledWidth);
      if (_textField.text.length > 0)
        _textField.fitText(_textField.text);
      drawBackground(getBackgroundColor(_project));
      //_textField.setActualSize(Math.max(getExplicitOrMeasuredWidth(), unscaledWidth),  _textField.getExplicitOrMeasuredHeight());
      //_textField.move(0, (unscaledHeight - _textField.getExplicitOrMeasuredHeight()) / 2);
    }

    private function getDefaultTextFormat():TextFormat
    {
      var tf:TextFormat = new TextFormat("Verdana", 12, ColorEnum.BLACK.code, true);
      return tf;
    }

    private function getBackgroundColor(project:Project):ColorEnum
    {
      if (project.activity == "Sleeping")
      {
        if (project.lastBuildStatus == "Unknown")
          return ColorEnum.WHITE;
        if (project.lastBuildStatus == "Success")
          return ColorEnum.GREEN;
        return ColorEnum.RED;
      }
      if (project.activity == "Building" || project.activity == "CheckingModifications")
      {
        return ColorEnum.YELLOW;
      }
      return ColorEnum.BLACK;
    }

    private function drawBackground(color:ColorEnum):void
    {
      var h:Number = _textField.y + _textField.height + Number(getStyle("paddingTop")) + Number(getStyle("paddingBottom"));
      var g:Graphics = this.graphics;
      g.beginFill(color.code);
      g.drawRect(0, 0, width + Number(getStyle("paddingLeft")) + Number(getStyle("paddingRight")), h);
      g.endFill();
    }

    private function toggleColor(event:TimerEvent):void
    {
      var currentColor:Number = Number(getStyle("backgroundColor"));
      var newColor:Number = 0;
      currentColor == ColorEnum.RED.code ? newColor = 0x990000 : newColor = ColorEnum.RED.code;
      setStyle("backgroundColor", newColor);
    }
  }
}
