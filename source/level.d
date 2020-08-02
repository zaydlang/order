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
import sidebar;
import button;
import foodmanager;

static import raylib;

class LevelScene : Scene2D {
    private static string      title;
    private static string      description;
    private static FoodManager food_manager;

    this(string title, string description, FoodManager food_manager) {
        this.title        = title;
        this.description  = description;
        this.food_manager = food_manager;
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
                tile_entity.add_component(new Tile(x, y, TILE.TYPE.EMPTY));
            }
        }

        // add board manager
        board_entity.add_component(new BoardManager());

        // set up the sidebar
        auto sidebar_entity = create_entity("sidebar", Vector2(LEVEL.SIDEBAR_CENTER_X, LEVEL.SIDEBAR_CENTER_Y));
        sidebar_entity.add_component(new SidebarManager());
        
        float tile_x = LEVEL.SIDEBAR_FIRST_TILE_OFFSET_X;
        int y = 0;
        for (int current_tile = 0; current_tile < TILE.NUM_TILES; current_tile++) {
            auto tile_data = TileData.get_tile_data(null, current_tile);

            // can we edit this tile in the sidebar? if so, let's put it in the sidebar.
            if (tile_data.is_editable()) {
                auto color = tile_data.get_color();
                float tile_y = LEVEL.SIDEBAR_FIRST_TILE_OFFSET_Y + y * (LEVEL.SIDEBAR_BUTTON_HEIGHT);

                auto button_entity = create_entity("tile_button_" ~ to!string(current_tile), Vector2(tile_x, tile_y));
                button_entity.add_component(new ColorRect(Vector2(LEVEL.SIDEBAR_BUTTON_WIDTH, LEVEL.SIDEBAR_BUTTON_HEIGHT), color));
                button_entity.add_component(new TileButton(cast(int)(tile_x), cast(int)(tile_y), current_tile));
                y++;
            }
        }

        // add a food manager to deal with the logic of sending out and receiving food
        auto food_manager_entity = create_entity("food_manager", Vector2(0, 0));
        food_manager_entity.add_component(new FoodManager_1());
        
        // add start adn stop button
        auto start_button_entity = create_entity("start_button", Vector2(LEVEL.START_BUTTON_CENTER_X, LEVEL.START_BUTTON_CENTER_Y));
        start_button_entity.add_component(new ColorRect(Vector2(LEVEL.START_BUTTON_WIDTH, LEVEL.START_BUTTON_HEIGHT), LEVEL.START_BUTTON_COLOR));
        start_button_entity.add_component(new StartButton());
    }
}
