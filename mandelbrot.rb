require 'chunky_png'
require 'complex'

def generate(width, height, max)
  png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::WHITE)
  for row in 0...height
    puts "#{(((row+1).to_f/height)*100).round(2)}% (#{row+1}/#{height})"
    for col in 0...width
      c = Complex(((col - width/2)*4.0)/ width, (row - height/2)*4.0 / width)
      z = Complex(0)
      itteration = 0
      while z.abs <= 2 and itteration < max
        z = (z ** 2) + c
        itteration += 1
      end
      png[col, row] = ChunkyPNG::Color.grayscale(itteration * 256/max)
    end
  end
  png.save("mandelbrot-#{width}x#{height}-#{max}.png")
end

print "Please enter width: "
width = gets.chomp.to_i
print "Please enter height: "
height = gets.chomp.to_i
print "Please enter color-depth: "
depth = gets.chomp.to_i
puts

t = Time.now
generate(width, height, depth)
puts Time.now - t
