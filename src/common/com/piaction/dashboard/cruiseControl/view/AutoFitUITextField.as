package com.piaction.dashboard.cruiseControl.view
{
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  import mx.core.UITextField;
  import mx.core.UITextFormat;

  public class AutoFitUITextField extends UITextField
  {
    private var _format:UITextFormat;

    public static var MIN_POINT_SIZE:uint = 6;
    public static var MAX_POINT_SIZE:uint = 256;

    public function AutoFitUITextField(tf:UITextFormat=null)
    {
      super();

      autoSize = TextFieldAutoSize.NONE;
      wordWrap = true;
      background = false;

      if (tf != null)
      {
        _format = tf;
      }
      else
      {
        _format = getDefaultTextFormat();
      }
      //defaultTextFormat = _format;
      setTextFormat(_format);
    }

    public function changeSize(size:uint=12):void
    {
      if (size > MIN_POINT_SIZE - 1)
      {
        _format.size = size;
        setTextFormat(_format);
      }
    }

    private function getDefaultTextFormat():UITextFormat
    {
      var format:UITextFormat = new UITextFormat(systemManager);
      format.size = 10;
      format.bold = false;
      format.leading = 0;
      format.align = TextFormatAlign.CENTER;
      format.color = 0x000000;
      return format;
    }

    public function fitText(maxLines:uint = 1, toUpper:Boolean = false, targetWidth:Number = -1):uint
    {
      /*if (text.length == 0)
      {
        changeSize(MIN_POINT_SIZE);
        return MIN_POINT_SIZE;
      }*/

      if (text.length == 0)
      {
        changeSize(MIN_POINT_SIZE);
        return MIN_POINT_SIZE;
      }

      var msg:String = new String(text);
      msg = toUpper ? msg.toUpperCase() : msg;

      if (targetWidth == -1)
      {
        targetWidth = width;
      }

      var pixelsPerChar:Number = targetWidth / msg.length;

      var pointSize:Number = Math.min(MAX_POINT_SIZE, Math.round(pixelsPerChar * 1.8 * maxLines));

      if (pointSize < 6)
      {
        // the point size is too small
        return pointSize;
      }

      changeSize(pointSize);

      if (this.numLines > maxLines)
      {
        return shrinkText(--pointSize, maxLines);
      }
      else
      {
        return growText(pointSize, maxLines);
      }
    }

    private function growText(pointSize:Number, maxLines:uint = 1):Number
    {
      if (pointSize >= MAX_POINT_SIZE)
      {
        return pointSize;
      }

      changeSize(pointSize + 1);

      if (numLines > maxLines)
      {
        // set it back to the last size
        changeSize(pointSize);
        return pointSize;
      }
      else
      {
        return growText(pointSize + 1, maxLines);
      }
    }

    private function shrinkText(pointSize:Number, maxLines:uint=1):Number
    {
      if (pointSize <= MIN_POINT_SIZE)
      {
        return pointSize;
      }

      changeSize(pointSize);

      if (numLines > maxLines)
      {
        return shrinkText(pointSize - 1, maxLines);
      }
      else
      {
        return pointSize;
      }
    }
  }
}
