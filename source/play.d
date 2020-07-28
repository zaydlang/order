module play;

import re;
import re.gfx;
import re.math;

static import raylib;

class LevelScene : Scene2D {
    private static const int TITLE_PADDING_X = 10;
    private static const int TITLE_PADDING_Y = 10;

    private string title;
    private string description;
    
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
        auto title_text_entity = create_entity("title", Vector2(TITLE_PADDING_X, TITLE_PADDING_Y));
        auto title_text = title_text_entity.add_component(new Text(Text.default_font, title, 10, Colors.BROWN));
    }
}
