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
