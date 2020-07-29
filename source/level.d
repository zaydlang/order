module level;

import re;
import re.gfx;
import re.gfx.shapes.rect;
import re.math;

import constants;
import grid;

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
    }
}
