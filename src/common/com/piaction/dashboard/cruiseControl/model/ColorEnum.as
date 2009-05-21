package com.piaction.dashboard.cruiseControl.model
{
  public class ColorEnum
  {
    public static const BLACK:ColorEnum = new ColorEnum(0x000000);
    public static const RED:ColorEnum = new ColorEnum(0xFF0000);
    public static const RED_LIGHT:ColorEnum = new ColorEnum(0x990000);
    public static const GREEN:ColorEnum = new ColorEnum(0x00FF00);
    public static const BLUE:ColorEnum = new ColorEnum(0x0000FF);
    public static const ORANGE:ColorEnum = new ColorEnum(0xFF8000);
    public static const YELLOW:ColorEnum = new ColorEnum(0xFFFF00);
    public static const WHITE:ColorEnum = new ColorEnum(0xFFFFFF);

    public static const values:Array = new Array(BLACK, RED, GREEN, BLUE, ORANGE, YELLOW, WHITE);

    private var _code:Number;

    public function ColorEnum(code:Number)
    {
      super();
      this._code = code;
    }

    public function get code():Number
    {
      return _code;
    }

    public function equals(color:ColorEnum):Boolean
    {
      if (color == null)
        return false;
      return _code == color._code;
    }
  }
}
