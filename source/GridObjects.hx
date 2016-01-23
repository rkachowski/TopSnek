import flixel.FlxSprite;
import Player.GridPosition;
class GridObject extends FlxSprite
{
    public var GridPosition(default,set):GridPosition;
    public function set_GridPosition(gp:GridPosition)
    {
        this.x = Std.int(gp.x * _grid.GridWidth);
        this.y = Std.int(gp.y*_grid.GridHeight);
        return this.GridPosition = gp;
    }

    private var _grid:SnakeGrid;
    public function new(grid:SnakeGrid, X:Float = 0, Y:Float = 0, ?SimpleGraphic:Dynamic)
    {
        super(X, Y);
        _grid = grid;

        set_GridPosition(new GridPosition(Std.int(x / grid.GridWidth),Std.int( y / grid.GridHeight)));
        grid.addGridObject(this);
    }
}

class Food extends GridObject
{
    public function new(grid:SnakeGrid,X:Float = 0, Y:Float = 0, ?SimpleGraphic:Dynamic)
    {
        super(grid);
        loadGraphic("assets/images/APPLE.png");
    }
}