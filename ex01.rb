
have_fun

letter = "a"
fill(black)

mouse_click do
  color(purple)
  text(letter, mouse_position)
end

key_press do
  letter = key
end
