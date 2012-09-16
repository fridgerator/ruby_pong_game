require "GameObject"

class Background < GameObject
	def initialize width, height
		surface = Rubygame::Surface.new [width, height]

		white = [255, 255, 255]

		# top
		surface.draw_box_s [0, 0], [surface.width, 10], white
		# left
		surface.draw_box_s [0, 0], [10, surface.height], white
		# bottom
		surface.draw_box_s [0, surface.height-10], [surface.width, surface.height], white
		# right
		surface.draw_box_s [surface.width-10, 0], [surface.width, surface.height], white
		# middle divide
		surface.draw_box_s [surface.width/2-5, 0], [surface.width/2+5, surface.height], white

		super 0, 0, surface
	end
end