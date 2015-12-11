# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  Triangle.new(a, b, c).type
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

class Triangle
  attr_reader :a, :b, :c
  def initialize(a, b, c)
    if (a <= 0 || b <= 0 || c <= 0)
      raise TriangleError, "A side is impossibly short"
    end
    @a, @b, @c = a, b, c
  end

  def type
    if is_equilateral?
      return :equilateral
    elsif is_isoceles?
      return :isosceles
    elsif is_scalene?
      return :scalene
    end    
  end

  private
  def is_equilateral?()
    (a == b && b == c)
  end

  def is_isoceles?()
    ((a == b && b != c) || (a == c && a != b) || (b == c && a != b))
  end

  def is_scalene?()
    (a != b && b != c)
  end
end
