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
  public class ProjectActivityEnum
  {
    public static const SLEEPING:ProjectActivityEnum = new ProjectActivityEnum("Sleeping");
    public static const BUILDING:ProjectActivityEnum = new ProjectActivityEnum("Building");
    public static const CHECKING_MODIFICATIONS:ProjectActivityEnum = new ProjectActivityEnum("CheckingModifications");

    public static const values:Array = new Array(SLEEPING, BUILDING, CHECKING_MODIFICATIONS);

    private var _label:String;

    public function ProjectActivityEnum(label:String)
    {
      super();
      this._label = label;
    }

    public function get label():String
    {
      return _label;
    }

    public function equals(activity:ProjectActivityEnum):Boolean
    {
      if (activity == null)
        return false;
      return _label == activity.label;
    }
  }
}
