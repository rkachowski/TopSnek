import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.addons.display.FlxNestedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import GridObjects.GridObject;
import SnakeGrid.SnakeGrid;
enum Direction
{
    Up;
    Down;
    Left;
    Right;
}

class GridPosition
{
    public var x:Int;
    public var y:Int;
    public function new(X:Int, Y:Int)
    {
        x = X;
        y = Y;
    }

    public function toString():String
    {
        return "x : "+this.x+" y : "+this.y;
    }
}





class Player extends GridObject
{
    public var Direction:Direction;
    var _snakeSegments:Array<GridObject>;

    var MIN_LENGTH:Int = 3;
    public function new(grid:SnakeGrid,X:Float = 0, Y:Float = 0, ?SimpleGraphic:Dynamic)
    {
        super(grid, X, Y);

        Direction = Right;
        loadGraphic("assets/images/HEAD.png");
        _snakeSegments = new Array<GridObject>();
        this.origin.x = 20;
        this.origin.y = 20;
    }

    public function addSegment()
    {
        var gridPosition:GridPosition;
        if(_snakeSegments.length == 0)
            gridPosition = this.GridPosition;
        else
            gridPosition = _snakeSegments[_snakeSegments.length-1].GridPosition;

        var segment = new GridObject(_grid);
        _grid.moveGridObject(segment, gridPosition);

        _snakeSegments.push(segment);

        //make previously last segment a body piece

        if(_snakeSegments.length > 1)
        {
            _snakeSegments[_snakeSegments.length-2].makeGraphic(_grid.GridWidth,_grid.GridHeight,FlxColor.WHITE);
        }

        _snakeSegments[_snakeSegments.length-1].loadGraphic("assets/images/TAIL.png");

        return segment;
    }

    public function nextPosition():GridPosition
    {
        switch(this.Direction)
        {
            case Left:
                return new GridPosition(this.GridPosition.x - 1, this.GridPosition.y);
            case Up:
                return new GridPosition(this.GridPosition.x, this.GridPosition.y-1);
            case Down:
                return new GridPosition(this.GridPosition.x, this.GridPosition.y+1);
            case Right:
                return new GridPosition(this.GridPosition.x + 1, this.GridPosition.y);
        }
    }

    public function updateSnake()
    {
        if(_snakeSegments.length > 0)
        {
            var n = _snakeSegments.length;
            while(n-- > 1)
            {
                _grid.moveGridObject(_snakeSegments[n], _snakeSegments[n-1].GridPosition );
                _snakeSegments[n].angle = _snakeSegments[n-1].angle;
            }

            _snakeSegments[0].GridPosition = this.GridPosition;
            _snakeSegments[0].angle = this.angle;
        }

        if(_snakeSegments.length > 2)
        {
            _snakeSegments[_snakeSegments.length  - 1].angle = _snakeSegments[_snakeSegments.length  - 2].angle;
        }

        _grid.moveGridObject(this, nextPosition());

        switch(this.Direction)
        {
            case Left:
                angle = 180;
            flipY = true;

            case Up:
                angle = 270;
                flipY = false;

            case Down:
                angle = 90;
                flipY = false;
            case Right:
                angle = 0;
                flipY = false;
        }
    }

    override public function update()
    {
        if(FlxG.keys.justReleased.DOWN)
        {
            Direction = Down;
        }
        if(FlxG.keys.justReleased.LEFT)
        {
            Direction = Left;
        }
        if(FlxG.keys.justReleased.RIGHT)
        {
            Direction = Right;
        }
        if(FlxG.keys.justReleased.UP)
        {
            Direction = Up;
        }

    }
}