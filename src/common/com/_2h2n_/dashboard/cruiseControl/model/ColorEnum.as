/*
 * Copyright 2011 Vichheann Saing (vichheann at gmail dot com)
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com._2h2n_.dashboard.cruiseControl.model
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
