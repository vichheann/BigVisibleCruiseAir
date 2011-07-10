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

package com._2h2n_.dashboard.cruiseControl.repository
{
  import com._2h2n_.dashboard.cruiseControl.model.Project;

  import mx.collections.ArrayCollection;

  public class CruiseControlRepository
  {
    [Bindable]
    public var projects:ArrayCollection;

    public function CruiseControlRepository()
    {
      projects = new ArrayCollection();
    }

    public function getProjectStatus(data:Object):ArrayCollection
    {
      var result:ArrayCollection = new ArrayCollection();
      var xml:XML = data as XML;
      if (xml!=null)
      {
        for each (var property:XML in xml.Project)
        {
          var project:Project = new Project(property.@name, property.@activity, property.@lastBuildStatus, property.@lastBuildLabel, property.@lastBuildTime, property.@url);
          result.addItem(project);
        }
      }
      projects.removeAll();
      projects = result;
      return projects;
    }
  }
}
