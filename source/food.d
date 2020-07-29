module food;

import re;
import re.math;
import re.ecs;

class Food : Component, Updatable {
    private static float SPEED = 20.0f;

    private Vector2 direction; // unit vector, either 0, 90, 180, or 270 degrees

    this() {
        direction = Vector2(0, 0); 
    }

    void update() {
        entity.position2 = entity.position2 + (direction * SPEED * Time.delta_time);
    }

    void rotate_left() {
        Vector2 temp;
        temp.x =  direction.y;
        temp.y = -direction.x;
        direction = temp;
    }

    void rotate_right() {
        Vector2 temp;
        temp.x = -direction.y;
        temp.y =  direction.x;
        direction = temp;
    }
}