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
  public class ProjectStatusEnum
  {
    public static const SUCCESS:ProjectStatusEnum = new ProjectStatusEnum("Success");
    public static const FAILURE:ProjectStatusEnum = new ProjectStatusEnum("Failure");
    public static const EXCEPTION:ProjectStatusEnum = new ProjectStatusEnum("Exception");
    public static const UNKNOWN:ProjectStatusEnum = new ProjectStatusEnum("Unknown");

    public static const values:Array = new Array(SUCCESS, FAILURE, EXCEPTION, UNKNOWN);

    private var _label:String;

    public function ProjectStatusEnum(label:String)
    {
      super();
      this._label = label;
    }

    public function get label():String
    {
      return _label;
    }

    public function equals(status:ProjectStatusEnum):Boolean
    {
      if (status == null)
        return false;
      return _label == status.label;
    }
  }
}
