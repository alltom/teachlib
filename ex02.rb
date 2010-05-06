
have_fun

balls = []
black_hole = BlackHole.new

mouse_click do
  new_ball = Ball.new
  balls.add(new_ball)
end

mouse_move do
  black_hole.position = mouse_position
end

draw do
  black_hole.draw
  for ball in balls
    black_hole.pull(ball)
    ball.draw
  end
end
