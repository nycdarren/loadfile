require 'minitest/autorun'
require 'load_file'

class XlfLoadFileTests < MiniTest::Test
  XLF = <<~EOF
    <loadfile>
      <entries>
        <entry control-number="test-000001">
          <volume>Import Test 01</volume>
          <image-path>IMAGES/001/</image-path>
          <image-name>test-000001.tif</image-name>
        </entry>
        <entry control-number="test-000002">
          <volume>Import Test 01</volume>
          <image-path>IMAGES/001/</image-path>
          <image-name>test-000002.tif</image-name>
        </entry>
        <entry control-number="test-000003">
          <volume>Import Test 01</volume>
          <image-path>IMAGES/001/</image-path>
          <image-name>test-000003.tif</image-name>
        </entry>
       <entry control-number="test-000004">
          <volume>Import Test 01</volume>
          <image-path>IMAGES/001/</image-path>
          <image-name>test-000004.tif</image-name>
        </entry>
      </entries>
    </loadfile>
  EOF



  def test_each
    io = StringIO.new(XLF)
    loadfile = LoadFile::XlfLoadFile.new(io)
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
                                  image_path: "IMAGES/001/test-000003.tif"),
     LoadFile::LoadFileEntry.new(control_number: "test-000004",
                                  volume: "Import Test 01",
                                  image_path: "IMAGES/001/test-000004.tif")
    ]
    assert_equal entries, expectation
  end
end
