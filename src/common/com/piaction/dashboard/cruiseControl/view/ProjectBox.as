package com.piaction.dashboard.cruiseControl.view
{
  import com.adobe.utils.ArrayUtil;
  import com.piaction.dashboard.cruiseControl.model.Preferences;
  import com.piaction.dashboard.cruiseControl.model.Project;

  import flash.events.Event;
  import flash.media.Sound;

  import mx.collections.ICollectionView;
  import mx.collections.IViewCursor;
  import mx.collections.Sort;
  import mx.collections.SortField;
  import mx.containers.VBox;

  public class ProjectBox extends VBox
  {
    private var _sort:Sort;
    private var _failedProjects:Array = new Array();

    [Bindable]
    public var preferences:Preferences;

    [Bindable]
    public var mute:Boolean;

    [Embed(source="/assets/buildFailed.mp3")]
    public var buildFailedClass:Class;

    [Embed(source="/assets/buildSuccessful.mp3")]
    public var buildSuccessfulClass:Class;

    public function ProjectBox()
    {
      super();
      _sort = new Sort();
      _sort.fields = [new SortField("lastBuildStatus"), new SortField("activity"), new SortField("name")];
      _sort.compareFunction = compareProjects;
    }

    private var _projects:ICollectionView;
    private var _projectsChanged:Boolean = false;
    [Bindable("projectsChanged")]
    public function get projects():ICollectionView
    {
      return _projects;
    }
    public function set projects(value:ICollectionView):void
    {
      _projects = value;
      if (_projects != null)
      {
        _projectsChanged = true;
        _projects.sort = _sort;
        _projects.refresh();
      }
      removeAllChildren();
      invalidateProperties();
      dispatchEvent(new Event("projectsChanged"));
    }

    override protected function createChildren():void
    {
      super.createChildren();
    }

    override protected function commitProperties():void
    {
      super.commitProperties();
      if (_projectsChanged)
      {
        var sounds:Array = new Array();
        var sound:Sound = null;
        var cursor:IViewCursor = _projects.createCursor();
        while(!cursor.afterLast)
        {
          var project:Project = Project(cursor.current);
          var projectStatusBox:ProjectStatusBox = new ProjectStatusBox();
          projectStatusBox.percentWidth = projectStatusBox.percentHeight = 100;
          projectStatusBox.preferences = preferences;
          projectStatusBox.project = project;
          addChild(projectStatusBox);
          cursor.moveNext();
          sound = updateSound(project);
          if (sound != null)
          {
            sounds.push(sound);
          }
        }
        if (!mute)
        {
          for (var i:int = 0; i < sounds.length; i++)
          {
            sounds[i].play();
          }
        }
        _projectsChanged = false;
      }
    }

    override protected function measure():void
    {
      super.measure();
    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);
    }

    private function updateSound(project:Project):Sound
    {
      var sound:Sound = null;
      if (project.hasFailed())
      {
        if (!ArrayUtil.arrayContainsValue(_failedProjects, project.name))
        {
          _failedProjects.push(project.name);
        }
        sound = new buildFailedClass() as Sound;
      }
      else
      {
        if (ArrayUtil.arrayContainsValue(_failedProjects, project.name) && project.isSuccessful())
        {
          sound = new buildSuccessfulClass() as Sound;
          ArrayUtil.removeValueFromArray(_failedProjects, project.name);
        }
      }
      return sound;
    }

    private function compareProjects(a:Object, b:Object, fields:Array = null):int
    {
      var proj1:Project = a as Project;
      var proj2:Project = b as Project;

      if (proj1.hasFailed())
        return -1;
      if (proj2.hasFailed())
        return 1;
      if (proj1.isBuilding())
        return -1;
      if (proj2.isBuilding())
        return 1;
      if (proj1.isCheckingModifications())
        return -1;
      if (proj2.isCheckingModifications())
        return 1;
      if (proj1.name < proj2.name)
        return -1;
      if (proj1.name > proj2.name)
        return 1;
      return 0;
    }

  }
}
