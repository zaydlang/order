module constants;

import re.gfx;
import re.math;

struct SCREEN {
	static const int     WIDTH                 = 800;
    static const int     HEIGHT                = 600;
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

    static const int     GRID_NUM_ROWS         = 16;
    static const int     GRID_NUM_COLS         = 24;
    static const int     GRID_PADDING          = 2;
    static const Color   GRID_COLOR            = Colors.BLACK;

    static const int     TILE_SIDE_LENGTH      = 25;
    static const float   FIRST_TILE_OFFSET_X   = LEVEL.BOARD_X + LEVEL.GRID_PADDING + cast(float)(LEVEL.TILE_SIDE_LENGTH) / 2;
    static const float   FIRST_TILE_OFFSET_Y   = LEVEL.BOARD_Y + LEVEL.GRID_PADDING + cast(float)(LEVEL.TILE_SIDE_LENGTH) / 2;
    static const Color   TILE_COLOR            = Colors.WHITE;

    static const int     BOARD_X               = TITLE_PADDING_X;
    static const int     BOARD_Y               = TITLE_PADDING_Y + TITLE_FONT_SIZE + 10;
    static const int     BOARD_WIDTH           = (TILE_SIDE_LENGTH + GRID_PADDING) * GRID_NUM_COLS + GRID_PADDING;
    static const int     BOARD_HEIGHT          = (TILE_SIDE_LENGTH + GRID_PADDING) * GRID_NUM_ROWS + GRID_PADDING;
    static const float   BOARD_CENTER_X        = cast(float)(BOARD_WIDTH)  / 2 + BOARD_X;
    static const float   BOARD_CENTER_Y        = cast(float)(BOARD_HEIGHT) / 2 + BOARD_Y;

    static const int     MOUSEOVER_HIGHLIGHT_R = 30;
    static const int     MOUSEOVER_HIGHLIGHT_G = 30;
    static const int     MOUSEOVER_HIGHLIGHT_B = 30;
}

struct DIRECTION {
    static const Vector2 RIGHT                 = Vector2( 1,  0);
    static const Vector2 UP                    = Vector2( 0, -1);
    static const Vector2 LEFT                  = Vector2(-1,  0);
    static const Vector2 DOWN                  = Vector2( 0,  1);
}