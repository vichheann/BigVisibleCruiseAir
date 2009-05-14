package com.piaction.dashboard.cruiseControl.view
{
  import com.adobe.utils.ArrayUtil;
  import com.piaction.dashboard.cruiseControl.model.Project;
  import com.piaction.dashboard.cruiseControl.model.ProjectActivityEnum;
  import com.piaction.dashboard.cruiseControl.model.ProjectStatusEnum;

  import flash.events.Event;
  import flash.media.Sound;

  import mx.collections.ICollectionView;
  import mx.collections.IViewCursor;
  import mx.collections.Sort;
  import mx.collections.SortField;
  import mx.containers.VBox;
  import mx.controls.Button;

  public class ProjectBox extends VBox
  {
    private var _sort:Sort;
    private var _failedProjects:Array = new Array();
    private var _muteSound:Boolean;

    [Embed(source="assets/klaxon.mp3")]
    public var klaxonClass:Class;

    [Embed(source="assets/applause.mp3")]
    public var applauseClass:Class;

    public function ProjectBox()
    {
      super();
      _sort = new Sort();
      _sort.fields = [new SortField("lastBuildStatus"), new SortField("activity")];
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
        var smallSound:Sound = null;
        var cursor:IViewCursor = _projects.createCursor();
        while(!cursor.afterLast)
        {
          var project:Project = Project(cursor.current);
          var projectStatusBox:ProjectStatusBox = new ProjectStatusBox();
          projectStatusBox.percentWidth = projectStatusBox.percentHeight = 100;
          projectStatusBox.project = project;
          addChild(projectStatusBox);
          cursor.moveNext();
          if (project.lastBuildStatus.equals(ProjectStatusEnum.FAILURE) && project.activity.equals(ProjectActivityEnum.SLEEPING))
          {
            if (!ArrayUtil.arrayContainsValue(_failedProjects, project.name))
            {
              _failedProjects.push(project.name);
            }
            smallSound = new klaxonClass() as Sound;
            sounds.push(smallSound);
          }
          else
          {
            if (ArrayUtil.arrayContainsValue(_failedProjects, project.name) && project.lastBuildStatus.equals(ProjectStatusEnum.SUCCESS) && project.activity.equals(ProjectActivityEnum.SLEEPING))
            {
              smallSound = new applauseClass() as Sound;
              sounds.push(smallSound);
              ArrayUtil.removeValueFromArray(_failedProjects, project.name);
            }
          }
        }
        if (!_muteSound)
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

    public function muteSound(button:Button):void
    {
      _muteSound = !_muteSound;
      _muteSound ? button.label = "Sound":button.label = "No Sound";
    }

    private function compareProjects(a:Object, b:Object, fields:Array = null):int
    {
      var proj1:Project = a as Project;
      var proj2:Project = b as Project;

      if (proj1.activity.equals(ProjectActivityEnum.SLEEPING) && proj1.lastBuildStatus.equals(ProjectStatusEnum.FAILURE))
        return -1;
      if (proj2.activity.equals(ProjectActivityEnum.SLEEPING) && proj2.lastBuildStatus.equals(ProjectStatusEnum.FAILURE))
        return 1;
      if (proj1.activity.equals(ProjectActivityEnum.BUILDING))
        return -1;
      if (proj2.activity.equals(ProjectActivityEnum.BUILDING))
        return 1;
      if (proj1.activity.equals(ProjectActivityEnum.CHECKING_MODIFICATIONS))
        return -1;
      if (proj2.activity.equals(ProjectActivityEnum.CHECKING_MODIFICATIONS))
        return 1;
      return 0;
    }

  }
}
