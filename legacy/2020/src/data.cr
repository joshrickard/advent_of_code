class Data
  def self.example_file_path(day : Int32, num : Int32) : String
    File.join(
      __DIR__,
      "..",
      "spec",
      "data",
      "day_#{day.to_s.rjust(2, '0')}_example#{num}.txt"
    )
  end

  def self.input_file_path(day : Int32) : String
    File.join(
      __DIR__,
      "..",
      "data",
      "day_#{day.to_s.rjust(2, '0')}.txt"
    )
  end
end
