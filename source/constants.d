module constants;

import re.gfx;
import re.math;

struct SCREEN {
	static const int     WIDTH                 = 640;
    static const int     HEIGHT                = 480;
}

struct LEVEL {
    static const int     TITLE_PADDING_X       = 5;
    static const int     TITLE_PADDING_Y       = 5;
    static const int     TITLE_FONT_SIZE       = 40;
    static const Color   TITLE_COLOR           = Colors.BLACK;

    static const int     DESCRIPTION_PADDING_X = 5;
    static const int     DESCRIPTION_PADDING_Y = DESCRIPTION_FONT_SIZE;
    static const int     DESCRIPTION_FONT_SIZE = 30;
    static const Color   DESCRIPTION_COLOR     = Colors.BLACK;

    static const int     GRID_NUM_ROWS         = 15;
    static const int     GRID_NUM_COLS         = 30;
    static const int     TILE_SIDE_LENGTH      = 20;
    static const Color   GRID_COLOR            = Colors.BLACK;

    static const int     BOARD_X               = TITLE_PADDING_X;
    static const int     BOARD_Y               = TITLE_PADDING_Y + TITLE_FONT_SIZE + 10;
    static const int     BOARD_WIDTH           = TILE_SIDE_LENGTH * GRID_NUM_COLS;
    static const int     BOARD_HEIGHT          = TILE_SIDE_LENGTH * GRID_NUM_ROWS;
    static const int     BOARD_CENTER_X        = BOARD_WIDTH  / 2 + BOARD_X;
    static const int     BOARD_CENTER_Y        = BOARD_HEIGHT / 2 + BOARD_Y;
}

struct DIRECTION {
    static const Vector2 RIGHT                 = Vector2( 1,  0);
    static const Vector2 UP                    = Vector2( 0, -1);
    static const Vector2 LEFT                  = Vector2(-1,  0);
    static const Vector2 DOWN                  = Vector2( 0,  1);
}