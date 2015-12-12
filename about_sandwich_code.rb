require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSandwichCode < Neo::Koan

  def count_lines(file_name)
    file = open(file_name) # using a file handle
    count = 0
    while file.gets # reading all the lines
      count += 1
    end
    count # return count
  ensure # odd, but neat that you can use implicit returns and ensure
    file.close if file # close the file handle if it does not equal false/nil
  end

  def test_counting_lines
    assert_equal 4, count_lines("example_file.txt")
  end

  # ------------------------------------------------------------------

  def find_line(file_name)
    file = open(file_name) # again, the handle/ensure-close structure
    while line = file.gets # allows capture for each iteration
      return line if line.match(/e/) # have to use explicit return
    end
  ensure
    file.close if file
  end

  def test_finding_lines
    assert_equal "test\n", find_line("example_file.txt")
  end

  # ------------------------------------------------------------------
  # THINK ABOUT IT:
  #
  # The count_lines and find_line are similar, and yet different.
  # They both follow the pattern of "sandwich code".
  #
  # Sandwich code is code that comes in three parts: (1) the top slice
  # of bread, (2) the meat, and (3) the bottom slice of bread.  The
  # bread part of the sandwich almost always goes together, but
  # the meat part changes all the time.
  #
  # Because the changing part of the sandwich code is in the middle,
  # abstracting the top and bottom bread slices to a library can be
  # difficult in many languages.
  #
  # - Coming from Java-land for the past couple of years, this is AOP, isn't
  # - it? It seems like it, just without @-tags for wrapping methods. @Before
  # - @After, @Transactional, @OneToOne, @Query... The file_sandwich method
  # - reads exactly like an advice.
  # http://docs.spring.io/spring/docs/current/spring-framework-reference/html/aop.html
  # - They're extensively used in Java and make life much easier.
  #
  # (Aside for C++ programmers: The idiom of capturing allocated
  # pointers in a smart pointer constructor is an attempt to deal with
  # the problem of sandwich code for resource allocation.)
  #
  # Consider the following code:
  #

  def file_sandwich(file_name)
    file = open(file_name)
    yield(file) # This resource is yielded into the block that is passed
  ensure # implicit return on the last item in the block, then pass control
    file.close if file # into here to close out the file
  end

  # Now we write:

  def count_lines2(file_name)
    file_sandwich(file_name) do |file|
      count = 0
      while file.gets
        count += 1
      end
      count
    end
  end

  def test_counting_lines2
    assert_equal 4, count_lines2("example_file.txt")
  end

  # ------------------------------------------------------------------

  def find_line2(file_name)
    file_sandwich(file_name) do |file|
      count = 0
      while line = file.gets
        return line if line.match(/e/)
      end
    end
  end

  def test_finding_lines2
    assert_equal "test\n", find_line2("example_file.txt")
  end

  # ------------------------------------------------------------------

  def count_lines3(file_name)
    open(file_name) do |file|
      count = 0
      while file.gets
        count += 1
      end
      count
    end
  end

  def test_open_handles_the_file_sandwich_when_given_a_block
    assert_equal 4, count_lines3("example_file.txt")
  end

end
