
class BlackHole
  attr_accessor :position
  
  def initialize(pos = nil)
    self.position = pos || [rand($app.width), rand($app.height)]
  end
  
  def draw
    $app.ellipse(position[0], position[1], 25, 25)
  end
  
  def pull(obj)
    obj.position[0] = (obj.position[0] * 0.99) + (self.position[0] * 0.01)
    obj.position[1] = (obj.position[1] * 0.99) + (self.position[1] * 0.01)
  end
end

class Ball
  attr_accessor :position
  
  def initialize(pos = nil)
    self.position = pos || [rand($app.width), rand($app.height)]
  end
  
  def draw
    $app.ellipse(position[0], position[1], 40, 40)
  end
end
