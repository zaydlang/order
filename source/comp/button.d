module button;

import re;
import re.math;
import re.gfx.shapes.rect;

import std.stdio;

import raylib;

import constants;
import food;
import sidebar;
import foodmanager;

abstract class Button : Component, Updatable {
    private float x;
    private float y;
    private float width;
    private float height;
    public bool pressed;
    public bool darkened;

    private ColorRect color_rect;

    // i require the centers to be passed in because ColorRect draws with respect to the center.
    this(float center_x, float center_y, float width, float height) {
        this.x          = center_x - (width  / 2);
        this.y          = center_y - (height / 2);
        this.width      = width;
        this.height     = height;
        this.pressed    = false;
        this.darkened   = false;
    }

    override void setup() {
        this.color_rect = entity.get_component!ColorRect;
    }

    void update() {
        Vector2 mouse_pos = GetMousePosition(); // GetMousePosition provided by raylib
        bool is_mouse_hovering = mouse_pos.x > x && mouse_pos.x < x + width &&
                                 mouse_pos.y > y && mouse_pos.y < y + height;
        if (is_mouse_hovering || pressed) {
            darken();
        } else {
            lighten();
        }

        if (is_mouse_hovering) {
            if (Input.is_mouse_down(MouseButton.MOUSE_LEFT_BUTTON)) {
                on_press();
            } else if (pressed) {
                 on_release();
            }
        }
    }

    void lighten() {
        if (darkened) {
            color_rect.color.r = cast(ubyte)(color_rect.color.r / LEVEL.MOUSEOVER_HIGHLIGHT_R);
            color_rect.color.g = cast(ubyte)(color_rect.color.g / LEVEL.MOUSEOVER_HIGHLIGHT_G);
            color_rect.color.b = cast(ubyte)(color_rect.color.b / LEVEL.MOUSEOVER_HIGHLIGHT_B);
            darkened = false;
        }
    }

    void darken() {
        if (!darkened) {
            color_rect.color.r = cast(ubyte)(color_rect.color.r * LEVEL.MOUSEOVER_HIGHLIGHT_R);
            color_rect.color.g = cast(ubyte)(color_rect.color.g * LEVEL.MOUSEOVER_HIGHLIGHT_G);
            color_rect.color.b = cast(ubyte)(color_rect.color.b * LEVEL.MOUSEOVER_HIGHLIGHT_B);
            darkened = true;
        }
    }

    abstract void on_press();
    abstract void on_release();
}

class TileButton : Button {
    private int type;

    this(float x, float y, int type) {
        super(x, y, LEVEL.SIDEBAR_BUTTON_WIDTH, LEVEL.SIDEBAR_BUTTON_HEIGHT);
        this.type = type;
    }

    override void on_press() {
        pressed = true;
        Core.primary_scene.get_entity("sidebar").get_component!SidebarManager.set_selected_value(type);
    }

    override void on_release() {

    }

    // called by the sidebar
    void release() {
        writeln(type);
        stdout.flush();
        pressed = false;
    }
}

// start and stop button are the same. the stop button changes floato 
// the start button and vice versa when pressed.
class StartButton : Button {
    private bool is_start; // are we currently a "start button"?

    this() {
        super(LEVEL.START_BUTTON_CENTER_X, LEVEL.START_BUTTON_CENTER_Y, LEVEL.START_BUTTON_WIDTH, LEVEL.START_BUTTON_HEIGHT);
        this.is_start = true;
    }

    override void on_press() {
        pressed = true;
    }

    override void on_release() {
        pressed = false;
        is_start = !is_start;

        updateColor();
        doAction();
    }

    void updateColor() {
        if (is_start) {
            color_rect.color = LEVEL.START_BUTTON_COLOR;
        } else {
            color_rect.color = LEVEL.STOP_BUTTON_COLOR;
        }

        darkened = false;
        darken();
    }

    void doAction() {
        if (!is_start) {
            Core.primary_scene.get_entity("food_manager").get_component!FoodManager().start();
        } else {
            Core.primary_scene.get_entity("food_manager").get_component!FoodManager().stop();
        }
    }
}