module tile;

import re;
import re.math;
import re.gfx;
import re.gfx.shapes.rect;

import std.conv;
import std.stdio;

import constants;
import food;

class Tile : Component {
    private int x;
    private int y;
    public  TileData tile_data;

    this(int x, int y, int type) {
        this.x = x;
        this.y = y;
        this.tile_data = TileData.get_tile_data(this, TILE.TYPE.EMPTY);
    }

    void set_type(int type) {
        tile_data = tile_data.get_tile_data(this, type);
        Core.primary_scene.get_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y)).get_component!ColorRect.color = tile_data.get_color();
    }

    // performs an action on food. assumes food is at the current tile.
    void act(Food food) {
        tile_data.act(food);
    }
}

abstract class TileData {
    private   Color color;
    private   bool  editable;
    protected Tile  parent;

    this(Tile parent, Color color, bool editable) {
        this.color    = color;
        this.editable = editable;
        this.parent   = parent;
    }

    static TileData get_tile_data(Tile parent, int type) {
        switch (type) {
            case TILE.TYPE.ENTRANCE:
                return new EntranceTileData(parent);
            case TILE.TYPE.EXIT:
                return new ExitTileData(parent);
            case TILE.TYPE.STRAIGHT:
                return new StraightTileData(parent);
            case TILE.TYPE.LEFT:
                return new LeftTileData(parent);
            case TILE.TYPE.RIGHT:
                return new RightTileData(parent);
            default:
                return new EmptyTileData(parent);
        }
    }

    Color get_color()   { return color; }
    bool  is_editable() { return editable; }

    abstract void act(Food food);
}

class EmptyTileData : TileData {
    this(Tile parent) { super(parent, Colors.WHITE, true); }

    override void act(Food food) {
        // food.crash();
    }
}

class StraightTileData : TileData {
    this(Tile parent) { super(parent, Colors.GRAY, true); }

    override void act(Food food) {
        food.move();
    }
}

class LeftTileData : TileData {
    this(Tile parent) { super(parent, Colors.BLUE, true); }

    override void act(Food food) {
        food.turn_left();
        food.move();
    }
}

class RightTileData : TileData {
    this(Tile parent) { super(parent, Colors.ORANGE, true); }

    override void act(Food food) {
        food.turn_right();
        food.move();
    }
}

class EntranceTileData : TileData {
    this(Tile parent) { super(parent, Colors.GREEN, false); }

    override void act(Food food) {
        // food.crash();
    }

    Food generate_food(int expected_exit_id) {
        // calculate the position
        float pos_x = LEVEL.FIRST_TILE_OFFSET_X + parent.x * (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING);
        float pos_y = LEVEL.FIRST_TILE_OFFSET_Y + parent.y * (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING);

        auto food_entity = Core.primary_scene.create_entity("food_entity", Vector2(pos_x, pos_y));
        Food food = new Food(expected_exit_id);
        food_entity.add_component(food);
        food_entity.add_component(new ColorRect(Vector2(LEVEL.FOOD_SIDE_LENGTH, LEVEL.FOOD_SIDE_LENGTH), LEVEL.FOOD_COLOR));
       
        // move and return
        food.move();
        return food;
    }
}

class ExitTileData : TileData {
    this(Tile parent) { super(parent, Colors.RED, false); }

    override void act(Food food) {
        // food.crash();
    }
}