require "GameObject"

class Paddle < GameObject
	def initialize x, y, up_key, down_key
		surface = Rubygame::Surface.new [20, 100]
		surface.fill [255, 255, 255]

		@up_key = up_key
		@down_key = down_key

		@moving_up = false
		@moving_down = false

		super x, y, surface
	end

	def center_y h
		self.y = h / 2 - @height / 2
	end

	def handle_event event
		case event
		when Rubygame::KeyDownEvent
			if event.key == @up_key
				@moving_up = true
			elsif event.key == @down_key
				@moving_down = true
			end
		when Rubygame::KeyUpEvent
			if event.key == @up_key
				@moving_up = false
			elsif event.key == @down_key
				@moving_down = false
			end
		end
	end

	def update
		self.y -= 5 if @moving_up && self.y > 0
		self.y += 5 if @moving_down && (self.y + self.height) < Screen.size[1]
	end
end