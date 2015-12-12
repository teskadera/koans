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
    @a, @b, @c = a, b, c

    if (self.a <= 0 || self.b <= 0 || self.c <= 0)
      raise TriangleError, "A side is non-existent or negative"
    end
    if all_sides_valid?
      raise TriangleError, "A side is impossibly short, with regards to the others"
    end

    self
  end

  def type
    if is_equilateral?
      return :equilateral
    elsif is_isoceles?
      return :isosceles
    end
    :scalene
  end

  private

  def all_sides_valid?
    if (((self.a + self.b) < self.c) && ((self.b + self.c) < self.a) && ((self.a + self.c) < self.b))
      return false
    end
    true
  end

  def is_equilateral?()
    (a == b && b == c)
  end

  def is_isoceles?()
    (a == b || b == c || a == c)
  end
end
