package;

import Player.SnakeGrid;
import Player;
import Player.GridPosition;
import flixel.util.FlxColor;
import flixel.addons.display.FlxGridOverlay;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    var _tick:Float = 0.2;
    var _sinceLastTick:Float = 0;

    var _grid:SnakeGrid;
    var _snake:Player;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
        super.create();

        setupBackground();
        setupGrid();

        var testApple = new Food(_grid);
        _grid.moveGridObject(testApple, new GridPosition(10,10));
        add(testApple);
	}

    private function setupGrid()
    {
        _grid = new SnakeGrid(40,40,34,18);

        _snake = new Player(_grid);
        add(_snake);
        _grid.moveGridObject(_snake,new GridPosition(5,5));
        add(_snake.addSegment());
    }
    private function setupBackground()
    {
        var bg = new FlxSprite();
        bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(bg);
        var grid = FlxGridOverlay.create(40,40,FlxG.width, FlxG.height);
        grid.alpha = 0.5;
        add(grid);
    }
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        _sinceLastTick += FlxG.elapsed;
        if(_sinceLastTick >= _tick)
        {
            _sinceLastTick = 0;
            trace(_snake.GridPosition);
            var object = _grid.getObjectAt(_snake.nextPosition());
            if(object != null)
            {
                if(Std.is(object, Food))
                {
                    remove(object);
                    add(_snake.addSegment());
                }
            }

            _snake.updateSnake();
        }

        if(FlxG.keys.justReleased.SPACE)
        {
            add(_snake.addSegment());
        }
	}
}