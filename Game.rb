$LOAD_PATH << '.'
require 'rubygame'
require 'Background'
require 'Paddle'
require 'Ball'

Screen = Rubygame::Screen.new [640, 480], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]

class Game
	def initialize
		
		Screen.title = "Pong"

		@queue = Rubygame::EventQueue.new
		@clock = Rubygame::Clock.new
		@clock.target_framerate = 60

		@background = Background.new Screen.width, Screen.height

		@player = Paddle.new 50, 10, Rubygame::K_W, Rubygame::K_S
		@enemy = Paddle.new Screen.width - 50 - @player.width, 10, Rubygame::K_UP, Rubygame::K_DOWN

		@player.center_y Screen.height
		@enemy.center_y Screen.height

		@ball = Ball.new Screen.width / 2, Screen.height / 2
	end

	def run!
		loop do
			update
			draw
			@clock.tick
		end
	end

	def update
		@queue.each do |ev|
			@player.handle_event ev
			@enemy.handle_event ev
			case ev
				when Rubygame::QuitEvent
					Rubygame.quit
					exit
				when Rubygame::KeyDownEvent
					if ev.key == Rubygame::K_ESCAPE
						@queue.push Rubygame::QuitEvent.new
					end
			end
		end
		@player.update
		@enemy.update
		@ball.update

		if collision? @ball, @player
			@ball.collision @player
		elsif collision? @ball, @enemy
			@ball.collision @enemy
		end
			
	end

	def draw
		Screen.fill [0, 0, 0]
		@background.draw Screen

		@player.draw Screen
		@enemy.draw Screen
		@ball.draw Screen

		Screen.flip
	end

	def collision? obj1, obj2
		return false if obj1.y + obj1.height < obj2.y
		return false if obj1.y > obj2.y + obj2.height
		return false if obj1.x + obj1.width < obj2.x
		return false if obj1.x > obj2.x + obj2.width
		return true
	end
end

g = Game.new
g.run!