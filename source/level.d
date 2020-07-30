module level;

import re;
import re.gfx;
import re.gfx.shapes.rect;
import re.math;

import std.conv;
import std.stdio;

import constants;
import tile;
import board;

static import raylib;

class LevelScene : Scene2D {

    private static string title;
    private static string description;
    
    // called when food comes in through an entrance or an exit to decide which food should come out
    // and whether or not the food went to the right exit, respectively.
    private void delegate() onEntry;
    private bool delegate() onExit;

    this(string title, string description, void delegate() onEntry, bool delegate() onExit) {
        this.title       = title;
        this.description = description;
        this.onEntry     = onEntry;
        this.onExit      = onExit;
    }
    
    override void on_start() {
        auto title_text_entity = create_entity("title", Vector2(LEVEL.TITLE_PADDING_X, LEVEL.TITLE_PADDING_Y));
        auto title_text = title_text_entity.add_component(new Text(Text.default_font, title, LEVEL.TITLE_FONT_SIZE, LEVEL.TITLE_COLOR));       

        auto description_text_entity = create_entity("description", Vector2(LEVEL.DESCRIPTION_PADDING_X, resolution.y - LEVEL.DESCRIPTION_PADDING_Y));
        auto description_text = description_text_entity.add_component(new Text(Text.default_font, description, LEVEL.DESCRIPTION_FONT_SIZE, LEVEL.DESCRIPTION_COLOR));

        auto board_entity = create_entity("board", Vector2(LEVEL.BOARD_CENTER_X, LEVEL.BOARD_CENTER_Y));
        board_entity.add_component(new ColorRect(Vector2(LEVEL.BOARD_WIDTH, LEVEL.BOARD_HEIGHT), LEVEL.GRID_COLOR));

        // set up the tile positions, and draw them to screen
        for (int x = 0; x < LEVEL.GRID_NUM_COLS; x++) {
            // get position of center of tile
            float tile_x = LEVEL.FIRST_TILE_OFFSET_X + (x * (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING));
            for (int y = 0; y < LEVEL.GRID_NUM_ROWS; y++) {
                float tile_y = LEVEL.FIRST_TILE_OFFSET_Y + (y * (LEVEL.TILE_SIDE_LENGTH + LEVEL.GRID_PADDING));

                auto tile_entity = create_entity("tile_" ~ to!string(x) ~ "_" ~ to!string(y), Vector2(tile_x, tile_y));
                tile_entity.add_component(new ColorRect(Vector2(LEVEL.TILE_SIDE_LENGTH, LEVEL.TILE_SIDE_LENGTH), LEVEL.TILE_COLOR));
            }
        }

        // add board manager
        board_entity.add_component(new BoardManager());

        auto sidebar_entity = create_entity("board", Vector2(LEVEL.SIDEBAR_CENTER_X, LEVEL.SIDEBAR_CENTER_Y));
        sidebar_entity.add_component(new ColorRect(Vector2(LEVEL.SIDEBAR_WIDTH, LEVEL.SIDEBAR_HEIGHT), LEVEL.GRID_COLOR));
        // set up the sidebar
        for (int x = 0; x < LEVEL.SIDEBAR_NUM_COLS; x++) {
            float tile_x = LEVEL.SIDEBAR_FIRST_TILE_OFFSET_X + (x * (LEVEL.SIDEBAR_TILE_SIDE_LENGTH  + LEVEL.GRID_PADDING));
            for (int y = 0; y < LEVEL.SIDEBAR_NUM_ROWS; y++) {
                float tile_y = LEVEL.SIDEBAR_FIRST_TILE_OFFSET_Y + (y * (LEVEL.SIDEBAR_TILE_SIDE_LENGTH  + LEVEL.GRID_PADDING));

                auto tile_entity = create_entity("sidebar_" ~ to!string(x) ~ "_" ~ to!string(y), Vector2(tile_x, tile_y));
                tile_entity.add_component(new ColorRect(Vector2(LEVEL.SIDEBAR_TILE_SIDE_LENGTH , LEVEL.SIDEBAR_TILE_SIDE_LENGTH ), LEVEL.TILE_COLOR));
            }
        }
    }
}
