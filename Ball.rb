require 'GameObject'

class Ball < GameObject
	def initialize x, y
		surface = Rubygame::Surface.load "ball.png"

		@vx = @vy = 5

		super x, y, surface
	end

	def update
		@x += @vx
		@y += @vy	

		# Left or Right
		@vx *= -1 if @x <= 10 || @x + @width >= Screen.width - 10

		# Top or Bottom
		@vy *= -1 if @y <= 10 or @y + @height >= Screen.height - 10
	end

	def collision paddle
		if paddle.x < Screen.width / 2
			unless @x < paddle.x - 5
				@x = paddle.x + paddle.width + 1
				@vx *= -1
			end
		else
			unless @x > paddle.x + 5
				@x = paddle.x - @width -1
				@vx *= -1
			end	
		end
	end
end