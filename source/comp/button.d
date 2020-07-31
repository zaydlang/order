module button;

import re;
import re.math;
import re.gfx.shapes.rect;

import std.stdio;

import raylib;

import constants;
import food;
import sidebar;

abstract class Button : Component, Updatable {
    private int x;
    private int y;
    private int width;
    private int height;
    public bool pressed;
    public bool darkened;

    private ColorRect color_rect;

    // i require the centers to be passed in because ColorRect draws with respect to the center.
    this(int center_x, int center_y, int width, int height) {
        this.x          = center_x - cast(int)(width  / 2);
        this.y          = center_y - cast(int)(height / 2);
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
            } else {
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

    this(int x, int y, int type) {
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