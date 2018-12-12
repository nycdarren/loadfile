require 'minitest/autorun'
require 'load_file'

class LfpLoadFileTests < MiniTest::Test
  LFP = <<~EOF
      IM,test-000001,S,0,@Import Test 01;IMAGES/001/;test-00
      IM,test-000002,C,0,@Import Test 01;IMAGES/001/;test-00
      IM,test-000003,D,0,@Import Test 01;IMAGES/001/;test-00
  EOF

  def test_each
    io = StringIO.new(LFP)
    loadfile = LoadFile::LfpLoadFile.new(io)
    entries = loadfile.entries.to_a
    expectation = [
      LoadFile::LoadFileEntry.new(control_number: "test-000001",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES/001/test-000001.tif"),
      LoadFile::LoadFileEntry.new(control_number: "test-000002",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES/001/test-000002.tif"),
      LoadFile::LoadFileEntry.new(control_number: "test-000003",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES/001/test-000003.tif")
    ]
     assert_equal entries, expectation
  end
end
