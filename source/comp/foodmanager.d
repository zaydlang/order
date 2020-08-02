module foodmanager;

import re;

import food;
import tile;
import constants;

import std.conv;
import std.algorithm;
import std.container;
import std.range;
import std.stdio;

// one class should be made per level.
abstract class FoodManager : Component, Updatable {
    private   Food[]             foods; // the list of food sent out
    private   EntranceTileData[] entrances;
    private   ExitTileData[]     exits;
    private   bool               enabled;

    this() {
        enabled = false;
    }

    void update() {
        if (enabled)
            on_entry(foods);
    }

    void deregister_food(Food food) {
        // removing items from an array is overly complicated.
        // so i wrote my own.
        food.state = FOOD.STATE.EXITTED;
    }

    void register_food(int entrance_id, int expected_exit) {
        auto food = entrances[entrance_id].generate_food(expected_exit);
        foods ~= food;
    }

    // (x, y) is the location of the entrance
    void register_entrance(int x, int y) {
        auto tile_entity = Core.primary_scene.get_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y)).get_component!Tile;
        tile_entity.set_type(TILE.TYPE.ENTRANCE);
        entrances ~= cast(EntranceTileData)(tile_entity.tile_data);
    }

    // (x, y) is the location of the exit
    void register_exit    (int x, int y) {
        auto tile_entity = Core.primary_scene.get_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y)).get_component!Tile;
        tile_entity.set_type(TILE.TYPE.EXIT);
        exits ~= cast(ExitTileData)(tile_entity.tile_data);
    }

    // tell the entrance tiles to start generating food
    void start() {
        enabled = true;
    }

    // destroy all foods and disable
    void stop() {
        enabled = false;

        for (int i = 0; i < foods.length; i++) {
            foods[i].entity.destroy();
        }
        foods.length = 0;
    }

    // takes in the list of foods on the board, and generates food if it should be sent out
    abstract void on_entry(Food[] foods);
}

// on level one, only one food will be sent out.
class FoodManager_1 : FoodManager {
    override void setup() {
        register_entrance(0,  0); // id 0
        register_exit    (10, 0); // id 0
    }

    override void on_entry(Food[] foods) {
        if (foods.length == 0)
            register_food(0, 0); // enter at id 0, exit to id 0.
    }
}