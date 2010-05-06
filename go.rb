
require "core_ext"
require "physics"
require "color"

# global $app is the instance of TeachRunner, the Processing::App
# global $sketch is the sketch being run (from ex01.rb, for example)

# The sketch is loaded in the outermost namespace so that it
# won't use Processing methods by accident. It must call have_fun
# to import the Fun module, though.

class TeachRunner < Processing::App
  attr_reader :handlers
  
  def initialize(script_filename, *args)
    @script_filename = script_filename
    @handlers = Hash.new { |hash, key| hash[key] = [] }
    super *args
  end
  
  def setup
    textFont(loadFont("ArialRoundedMTBold-25.vlw"))
    smooth
    
    load_script(@script_filename)
  end
  
  def draw
    handlers[:draw].each { |block| block[] }
  end
  
  def mouse_pressed
    handlers[:click].each { |block| block[] }
  end
  
  def mouse_moved
    handlers[:mouse_move].each { |block| block[] }
  end
  
  def key_typed
    handlers[:key_press].each { |block| block[] }
  end
end

module FunCallbacks
  def draw(&block)
    $app.handlers[:draw] << block
  end
  
  def mouse_click(&block)
    $app.handlers[:click] << block
  end
  
  def mouse_move(&block)
    $app.handlers[:mouse_move] << block
  end
  
  def key_press(&block)
    $app.handlers[:key_press] << block
  end
end

module Fun
  include Color
  include FunCallbacks
  
  def fill(color)
    $app.background(*color)
  end
  
  def color(color)
    $app.fill(*color)
    $app.stroke(*color)
  end
  
  def mouse_position
    [$app.mouseX, $app.mouseY]
  end
  
  def text(text, pos = [0, 0])
    unless Array === pos && pos.length == 2
      $stderr.puts "error: invalid arguments to text()"
      return
    end
    $app.text(text, pos[0], pos[1])
  end
  
  def key
    $app.key
  end
end

def load_script(filename)
  require filename
end

def have_fun
  $script = self
  include Fun
end

$app = TeachRunner.new(ARGV[0] || "ex01.rb", :title => "My Sketch", :width => 800, :height => 600)
