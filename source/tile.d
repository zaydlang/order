module tile;

import re;
import re.gfx;
import re.gfx.shapes.rect;

import std.conv;

import constants;
import food;

class Tile : Component {
    private int x;
    private int y;
    private TileData tile_data;

    this(int x, int y, int type) {
        this.x = x;
        this.y = y;
        this.tile_data = TileData.get_tile_data(TILE.TYPE.EMPTY);
    }

    void set_type(int type) {
        tile_data = tile_data.get_tile_data(type);
        Core.primary_scene.get_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y)).get_component!ColorRect.color = tile_data.get_color();
    }

    // performs an action on food. assumes food is at the current tile.
    void act(Food food) {
        tile_data.act(food);
    }
}

abstract class TileData {
    private Color color;
    private bool  editable;

    this(Color color, bool editable) {
        this.color       = color;
        this.editable = editable;
    }

    static TileData get_tile_data(int type) {
        switch (type) {
            case TILE.TYPE.ENTRANCE:
                return new EntranceTileData();
            case TILE.TYPE.EXIT:
                return new ExitTileData();
            case TILE.TYPE.STRAIGHT:
                return new StraightTileData();
            case TILE.TYPE.LEFT:
                return new LeftTileData();
            case TILE.TYPE.RIGHT:
                return new RightTileData();
            default:
                return new EmptyTileData();
        }
    }

    Color get_color()   { return color; }
    bool  is_editable() { return editable; }

    abstract void act(Food food);
}

class EmptyTileData : TileData {
    this() { super(Colors.WHITE, true); }

    override void act(Food food) {
        // food.crash();
    }
}

class StraightTileData : TileData {
    this() { super(Colors.GRAY, true); }

    override void act(Food food) {
        food.move();
    }
}

class LeftTileData : TileData {
    this() { super(Colors.BLUE, true); }

    override void act(Food food) {
        food.turn_left();
        food.move();
    }
}

class RightTileData : TileData {
    this() { super(Colors.ORANGE, true); }

    override void act(Food food) {
        food.turn_right();
        food.move();
    }
}

class EntranceTileData : TileData {
    this() { super(Colors.GREEN, false); }

    override void act(Food food) {
        // food.crash();
    }
}

class ExitTileData : TileData {
    this() { super(Colors.RED, false); }

    override void act(Food food) {
        // food.crash();
    }
}