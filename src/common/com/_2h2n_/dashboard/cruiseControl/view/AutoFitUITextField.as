package com._2h2n_.dashboard.cruiseControl.view
{
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  import mx.core.UITextField;
  import mx.core.UITextFormat;

  public class AutoFitUITextField extends UITextField
  {
    private var _format:UITextFormat;

    public static var MIN_POINT_SIZE:uint = 6;
    public static var MAX_POINT_SIZE:uint = 127;

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

    public function fitText(targetWidth:Number, targetHeight:Number):uint
    {
      width = targetWidth;
      height = targetHeight;
      changeSize(MIN_POINT_SIZE);

      if (text.length == 0)
      {
        return MIN_POINT_SIZE;
      }

      var pointSize:Number = MIN_POINT_SIZE;

      if (textHeight > targetHeight)
      {
        return shrinkText(--pointSize, targetHeight - 6);
      }
      else
      {
        return growText(pointSize, targetHeight - 6);
      }
    }

    private function growText(pointSize:Number, targetHeight:Number):Number
    {
      if (pointSize >= MAX_POINT_SIZE)
      {
        return pointSize;
      }

      changeSize(pointSize + 1);

      if (textHeight > targetHeight || numLines > 1)
      {
        // set it back to the last size
        changeSize(pointSize);
        return pointSize;
      }
      else
      {
        return growText(pointSize + 1, targetHeight);
      }
    }

    private function shrinkText(pointSize:Number, targetHeight:Number):Number
    {
      if (pointSize <= MIN_POINT_SIZE)
      {
        return pointSize;
      }

      changeSize(pointSize);

      if (textHeight > targetHeight)
      {
        return shrinkText(pointSize - 1, targetHeight);
      }
      else
      {
        return pointSize;
      }
    }
  }
}
