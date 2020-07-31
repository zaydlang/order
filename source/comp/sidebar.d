module sidebar;

import re;
import re.math;
import re.ecs;
import re.gfx.shapes.rect;

import constants;
import tile;
import button;

import std.stdio;
import std.conv;

import raylib;

class SidebarManager : Component {
    // stores the current selected value
    private int selected_value;

    override void setup() {
        // Core.primary_scene.get_entity("tilebutton_" + to!string(selected_value)).get_component!TileButton.release();
        selected_value = TILE.TYPE.STRAIGHT;
    }

    public int get_selected_value() {
        return selected_value;
    }

    public void set_selected_value(int new_selected_value) {
        if (selected_value != new_selected_value) {
            writeln(new_selected_value); stdout.flush();
            Core.primary_scene.get_entity("tile_button_" ~ to!string(selected_value)).get_component!TileButton.release();
            selected_value = new_selected_value;
        }
    }
}