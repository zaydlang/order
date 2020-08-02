module food;

import re;
import re.math;
import re.ecs;

import std.conv;
import std.stdio;

import tile;
import constants;

class Food : Component {
    private static float DURATION   = 0.3f;
    private static int   DISTANCE = LEVEL.GRID_PADDING + LEVEL.TILE_SIDE_LENGTH;

    private Vector3 direction;        // unit vector, either 0, 90, 180, or 270 degrees
    private int     expected_exit_id; // if, on exit, the current exit's id does not match this id, the level solution fails.
    public  int     state;

    this(int expected_exit_id) {
        direction = Vector3(1, 0, 0);
        this.expected_exit_id = expected_exit_id; 
        this.state = FOOD.STATE.MOVING;
    }

    void move() {
        Vector3 new_position = entity.transform.position + direction * DISTANCE;
        auto tween = Tweener.tween!Vector3(entity.transform.position,
                entity.transform.position, new_position, DURATION, &Ease.LinearNone);
        tween.set_callback((tween) { check_tile(); });
        
        tween.start();
    }

    void check_tile() {
        int x = cast(int)((entity.transform.position.x - LEVEL.BOARD_X) / (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING));
        int y = cast(int)((entity.transform.position.y - LEVEL.BOARD_Y) / (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING));
        auto tile = Core.primary_scene.get_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y)).get_component!Tile();
        tile.act(this);
    }

    void turn_left() {
        Vector3 temp;
        temp.x =  direction.y;
        temp.y = -direction.x;
        temp.z =  direction.z;
        direction = temp;
    }

    void turn_right() {
        Vector3 temp;
        temp.x = -direction.y;
        temp.y =  direction.x;
        temp.z =  direction.z;
        direction = temp;
    }
}