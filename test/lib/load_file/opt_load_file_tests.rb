require 'minitest/autorun'
require 'load_file'

class OptLoadFileTests < MiniTest::Test
  OPT = <<~EOF
      test-000001,Import Test 01,IMAGES\001\test-000001.tif,Y,,,1
      test-000002,Import Test 01,IMAGES\001\test-000002.tif,Y,,,1
      test-000003,Import Test 01,IMAGES\001\test-000003.tif,Y,,,2
  EOF
  
  def test_each
    io = StringIO.new(OPT)
    loadfile = LoadFile::OptLoadFile.new(io)
    entries = loadfile.entries.to_a
    expectation = [
      LoadFile::LoadFileEntry.new(control_number: "test-000001",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES\001\test-000001.tif"),
      LoadFile::LoadFileEntry.new(control_number: "test-000002",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES\001\test-000002.tif"),
      LoadFile::LoadFileEntry.new(control_number: "test-000003",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES\001\test-000003.tif")
    ]
    
    assert_equal entries, expectation
  end
end
