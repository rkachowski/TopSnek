import Player.GridPosition;
import GridObjects.GridObject;
class SnakeGrid
{
    public var GridWidth:Int;
    public var GridHeight:Int;
    var _widthInCells:Int;
    var _heightInCells:Int;
    var _cells:Array<Array<GridObject>>;

    public function new(gridWidth:Int, gridHeight:Int, widthInCells:Int, heightInCells:Int)
    {
        GridWidth = gridWidth;
        GridHeight = gridHeight;
        _heightInCells = heightInCells;
        _widthInCells = widthInCells;

        _cells = new Array<Array<GridObject>>();
        for (i in 0..._widthInCells)
        {
            var cell = new Array<GridObject>();
            _cells.push(cell);
        }
    }

    public function addGridObject(object:GridObject)
    {
        _cells[object.GridPosition.x][object.GridPosition.y] = object;
    }

    public function moveGridObject(object:GridObject, newPosition:GridPosition)
    {
        _cells[object.GridPosition.x][object.GridPosition.y] = null;

        object.GridPosition = keepInsideMap(newPosition);
        addGridObject(object);
    }

    public function randomGridPosition():GridPosition
    {
        return new GridPosition(Std.random(_widthInCells), Std.random(_heightInCells));
    }

    private function keepInsideMap(position:GridPosition):GridPosition
    {
        var newPosition = new GridPosition(position.x, position.y);
        if (position.x >= _widthInCells)
        {
            newPosition.x = 0;
        }
        if (position.x < 0)
        {
            newPosition.x = _widthInCells - 1;
        }
        if (position.y >= _heightInCells)
        {
            newPosition.y = 0;
        }
        if (position.y < 0)
        {
            newPosition.y = _heightInCells - 1;
        }
        return newPosition;
    }

    public function print()
    {
        trace(_cells);
    }

    public function getObjectAt(position:GridPosition):GridObject
    {
        var safePosition = keepInsideMap(position);
        return _cells[safePosition.x][safePosition.y];
    }
}