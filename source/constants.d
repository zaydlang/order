module constants;

import re.gfx;
import re.math;

struct SCREEN {
	static const int     WIDTH                       = 800;
    static const int     HEIGHT                      = 600;
}

struct LEVEL {
    static const int     TITLE_PADDING_X             = 5;
    static const int     TITLE_PADDING_Y             = 5;
    static const int     TITLE_FONT_SIZE             = 40;
    static const Color   TITLE_COLOR                 = Colors.BLACK;

    static const int     DESCRIPTION_PADDING_X       = 5;
    static const int     DESCRIPTION_PADDING_Y       = DESCRIPTION_FONT_SIZE;
    static const int     DESCRIPTION_FONT_SIZE       = 30;
    static const Color   DESCRIPTION_COLOR           = Colors.BLACK;

    static const int     GRID_NUM_ROWS               = 16;
    static const int     GRID_NUM_COLS               = 24;
    static const int     GRID_PADDING                = 2;
    static const Color   GRID_COLOR                  = Colors.BLACK;

    // this could use some major refactoring
    static const int     TILE_SIDE_LENGTH            = 25;
    static const float   FIRST_TILE_OFFSET_X         = LEVEL.BOARD_X + LEVEL.GRID_PADDING + cast(float)(LEVEL.TILE_SIDE_LENGTH) / 2;
    static const float   FIRST_TILE_OFFSET_Y         = LEVEL.BOARD_Y + LEVEL.GRID_PADDING + cast(float)(LEVEL.TILE_SIDE_LENGTH) / 2;
    static const Color   TILE_COLOR                  = Colors.WHITE;

    static const int     BOARD_X                     = TITLE_PADDING_X;
    static const int     BOARD_Y                     = TITLE_PADDING_Y + TITLE_FONT_SIZE + 10;
    static const int     BOARD_WIDTH                 = (TILE_SIDE_LENGTH + GRID_PADDING) * GRID_NUM_COLS + GRID_PADDING;
    static const int     BOARD_HEIGHT                = (TILE_SIDE_LENGTH + GRID_PADDING) * GRID_NUM_ROWS + GRID_PADDING;
    static const float   BOARD_CENTER_X              = cast(float)(BOARD_WIDTH)  / 2 + BOARD_X;
    static const float   BOARD_CENTER_Y              = cast(float)(BOARD_HEIGHT) / 2 + BOARD_Y;

    static const int     SIDEBAR_X                   = SCREEN.WIDTH - SIDEBAR_WIDTH - TITLE_PADDING_X;
    static const int     SIDEBAR_Y                   = BOARD_Y;
    static const int     SIDEBAR_NUM_ROWS            = 4;
    static const int     SIDEBAR_WIDTH               = 100;
    static const int     SIDEBAR_HEIGHT              = SIDEBAR_BUTTON_HEIGHT * SIDEBAR_NUM_ROWS;
    static const int     SIDEBAR_BUTTON_WIDTH        = SIDEBAR_WIDTH;
    static const int     SIDEBAR_BUTTON_HEIGHT       = 40;
    static const float   SIDEBAR_FIRST_TILE_OFFSET_X = LEVEL.SIDEBAR_X + cast(float)(LEVEL.SIDEBAR_BUTTON_WIDTH)  / 2;
    static const float   SIDEBAR_FIRST_TILE_OFFSET_Y = LEVEL.SIDEBAR_Y + cast(float)(LEVEL.SIDEBAR_BUTTON_HEIGHT) / 2;
    static const float   SIDEBAR_CENTER_X            = cast(float)(SIDEBAR_WIDTH)  / 2 + SIDEBAR_X;
    static const float   SIDEBAR_CENTER_Y            = cast(float)(SIDEBAR_HEIGHT) / 2 + SIDEBAR_Y;

    static const float   MOUSEOVER_HIGHLIGHT_R       = 0.8;
    static const float   MOUSEOVER_HIGHLIGHT_G       = 0.8;
    static const float   MOUSEOVER_HIGHLIGHT_B       = 0.8;

    static const float   FOOD_SIDE_LENGTH            = 25;
    static const Color   FOOD_COLOR                  = Colors.YELLOW;

    static const float   START_BUTTON_CENTER_X       = SIDEBAR_CENTER_X;
    static const float   START_BUTTON_CENTER_Y       = BOARD_Y + BOARD_HEIGHT - (START_BUTTON_HEIGHT / 2);
    static const float   START_BUTTON_WIDTH          = SIDEBAR_BUTTON_WIDTH;
    static const float   START_BUTTON_HEIGHT         = SIDEBAR_BUTTON_HEIGHT;
    static const Color   START_BUTTON_COLOR          = Colors.GREEN;
    static const Color   STOP_BUTTON_COLOR           = Colors.RED;
}

struct TILE {
    static const int     NUM_TILES                   = 6;
    
    enum TYPE {
        ENTRANCE = 0,
        EXIT     = 1,
        EMPTY    = 2,
        STRAIGHT = 3,
        LEFT     = 4,
        RIGHT    = 5
    }
}

struct FOOD {
    enum STATE {
        MOVING  = 0,
        STOPPED = 1,
        EXITTED = 2
    }
}
/*
struct TILE_COLOR {
    static const Color  EMPTY_COLOR
}*/
/*
struct DIRECTION {
    static const Vector2 RIGHT                       = Vector2( 1,  0);
    static const Vector2 UP                          = Vector2( 0, -1);
    static const Vector2 LEFT                        = Vector2(-1,  0);
    static const Vector2 DOWN                        = Vector2( 0,  1);
}*/