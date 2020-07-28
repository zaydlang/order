module constants;

import re.gfx;

struct SCREEN {
	static const int   WIDTH                 = 640;
    static const int   HEIGHT                = 480;
}

struct LEVEL {
    static const int   TITLE_PADDING_X       = 5;
    static const int   TITLE_PADDING_Y       = 5;
    static const int   TITLE_FONT_SIZE       = 40;
    static const Color TITLE_COLOR           = Colors.BLACK;

    static const int   DESCRIPTION_PADDING_X = 5;
    static const int   DESCRIPTION_PADDING_Y = DESCRIPTION_FONT_SIZE;
    static const int   DESCRIPTION_FONT_SIZE = 30;
    static const Color DESCRIPTION_COLOR     = Colors.BLACK;

    static const int   BOARD_X               = TITLE_PADDING_X;
    static const int   BOARD_Y               = TITLE_PADDING_Y + TITLE_FONT_SIZE + 10;
    static const int   BOARD_WIDTH           = SCREEN.WIDTH - (2 * BOARD_X);
    static const int   BOARD_HEIGHT          = SCREEN.HEIGHT - BOARD_Y - DESCRIPTION_PADDING_Y;
}