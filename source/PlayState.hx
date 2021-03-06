package;

import Reflect;
import Player;
import Player.GridPosition;

import Player.SnakePart;
import flixel.util.FlxColor;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import SnakeGrid.SnakeGrid;
import GridObjects.Food;

import GridObjects.GridObject;
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
        add(_snake.addSegment());
    }
    private function setupBackground()
    {
        var bg = new FlxSprite();
        bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(bg);
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        _sinceLastTick += FlxG.elapsed;
        if(_sinceLastTick >= _tick)
        {
            _sinceLastTick = 0;
            var object = _grid.getObjectAt(_snake.nextPosition());
            if(object != null)
            {
                collideWith(object);
            }

            _snake.updateSnake();
        }

        if(FlxG.keys.justReleased.SPACE)
        {
//            add(_snake.addSegment());
            _grid.print();
        }
	}

    function collideWith(object:GridObject)
    {
        if(Std.is(object, Food))
        {
            doEat(cast(object, Food));
        }

        if(Std.is(object, SnakePart))
        {
            trace("die!");
        }
    }

    function doEat(object:Food)
    {
        var position = null;
        while(position == null)
        {
            var p = _grid.randomGridPosition();
            if(_grid.getObjectAt(p) == null)
            {
                position = p;
            }
        }

        _grid.moveGridObject(object, position);
        add(_snake.addSegment());
    }
}