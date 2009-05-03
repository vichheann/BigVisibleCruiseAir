package com.piaction.dashboard.cruiseControl.view
{
  import com.piaction.dashboard.cruiseControl.model.Project;

  import flash.events.Event;

  import mx.collections.ICollectionView;
  import mx.collections.IViewCursor;
  import mx.containers.VBox;

  public class ProjectBox extends VBox
  {
    public function ProjectBox()
    {
      super();
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
      dispatchEvent(new Event("projectsChanged"));
      if (_projects != null)
        _projectsChanged = true;
      removeAllChildren();
      invalidateDisplayList();
    }

    override protected function createChildren():void
    {
      super.createChildren();
    }

    override protected function commitProperties():void
    {
      super.commitProperties();
    }

    override protected function measure():void
    {
      super.measure();
    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);
      if (_projectsChanged)
      {
        var cursor:IViewCursor = _projects.createCursor();
        while(!cursor.afterLast)
        {
          var project:Project = Project(cursor.current);
          var projectStatusBox:ProjectStatusBox = new ProjectStatusBox();
          projectStatusBox.project = project;
          projectStatusBox.percentWidth = projectStatusBox.percentHeight = 100;
          addChild(projectStatusBox);
          cursor.moveNext();
        }
        _projectsChanged = false;
      }
    }

  }
}
