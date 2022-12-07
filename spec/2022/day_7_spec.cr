require "spec"
require "../../src/2022/day_7"

describe Year2022::Day7 do
  it "solves part 1" do
    example = <<-EOS
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    EOS
    result = Year2022::Day7::Part1.run(IO::Memory.new(example))
    result.should eq(95437)
  end

  it "solves part 2" do
    example = <<-EOS
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    EOS
    result = Year2022::Day7::Part2.run(IO::Memory.new(example))
    result.should eq(24933642)
  end
end
