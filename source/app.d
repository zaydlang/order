import std.stdio;

import re;
import re.math;
import std.stdio;
import play;

class Game : Core {
	private static const int WIDTH  = 640;
	private static const int HEIGHT = 480;

	this() {
		super(WIDTH, HEIGHT, "Order");
	}

	override void initialize() {
		default_resolution = Vector2(WIDTH / 4, HEIGHT / 4);
		content.paths ~= "../content/";

		load_scenes([new LevelScene("Level 1", "test", null, null)]);
	}
}

void main() {
	auto game = new Game(); // init game
	game.run();
	game.destroy(); // clean up
}
