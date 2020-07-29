module tile;

import re;

import constants;
import food;

abstract class Tile : Component {
    override void setup() {
        
    }

    // performs an action on food. assumes food is at the current tile.
    abstract void act(Food food) {
        
    }
}

class StraightTile : Tile {
    override void act(Food food) {
        return;
    }
}

class LeftTile : Tile {
    override void act(Food food) {
        food.rotate_left();
    }
}

class RightTile : Tile {
    override void act(Food food) {
        food.rotate_right();
    }
}