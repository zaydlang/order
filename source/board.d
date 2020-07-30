module board;

import re;
import re.math;
import re.ecs;
import re.gfx.shapes.rect;

import constants;
import tile;

import std.stdio;
import std.conv;

import raylib;

class BoardManager : Component, Updatable {
    // stores the previously darkened tile
    private ColorRect color_rect;

    override void setup() {
        color_rect = null;
    }

    void update() {
        Vector2 mouse_pos = GetMousePosition(); // GetMousePosition() provided by raylib
        // convert mouse_pos to tile coordinates
        int x = cast(int)((mouse_pos.x - LEVEL.BOARD_X) / (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING));
        int y = cast(int)((mouse_pos.y - LEVEL.BOARD_Y) / (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING));

        if (x >= 0 && x < LEVEL.GRID_NUM_COLS && y >= 0 && y < LEVEL.GRID_NUM_ROWS) {
            // darken the tile
            ColorRect next_color_rect = Core.primary_scene.get_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y)).get_component!ColorRect;
            if (color_rect != next_color_rect) {
                // lighten the old tile
                if (color_rect !is null) {
                    lighten(color_rect);
                }

                darken(next_color_rect);
                color_rect = next_color_rect;
            }
        } else {
            if (color_rect !is null) {
                // lighten the old tile anyway. the mouse left the tile.
                lighten(color_rect);
                color_rect = null;
            }
        }
    }

    void lighten(ColorRect cr) {
        cr.color.r += LEVEL.MOUSEOVER_HIGHLIGHT_R;
        cr.color.g += LEVEL.MOUSEOVER_HIGHLIGHT_G;
        cr.color.b += LEVEL.MOUSEOVER_HIGHLIGHT_B;
    }

    void darken(ColorRect cr) {
        cr.color.r -= LEVEL.MOUSEOVER_HIGHLIGHT_R;
        cr.color.g -= LEVEL.MOUSEOVER_HIGHLIGHT_G;
        cr.color.b -= LEVEL.MOUSEOVER_HIGHLIGHT_B;
    }
}