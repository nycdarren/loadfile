module LoadFile
  # A value object representing an entry in a LoadFile
  class LoadFileEntry  

    attr_reader :control_number, :volume, :image_path
    #
    # setters with validation called from initialize
    def control_number=(control_number)
      invalidate(control_number, nil, "control number is required.")    
      invalidate(control_number, /zebra/, "control number can'y contain a zebra")
      validate(control_number, /^[a-zA-Z]{4}-\d{6}$/, "control number must have a the pattern of 4 characters, a -, followed by 6 numbers.")
      @control_number = control_number
    end
    def volume=(volume)
      invalidate(volume, nil, "volume is required.")    
      @volume = volume
    end
    def image_path=(image_path)
      invalidate(image_path, nil, "image path is required.")    
      validate(image_path, /\.tif$/ , "image path must end in .tif")
      @image_path = image_path
    end
    # validate :arg matches regular expression :exp or throw exception 
    def validate( arg, exp, msg )
      if  !(arg =~ exp)  
         raise ArgumentError.new("LoadFile::LoadFileEntry record - #{msg} [#{arg}].")
      else
        true
      end
    end
    # validate :arg dosen't match regex :exp :exp or throw exception
    #   exp = nil to test for empty strings when value required 
    def invalidate( arg, exp, msg )
      if (exp == nil ) 
        if ( arg == nil || arg.size == 0 ) 
         raise ArgumentError.new("LoadFile::LoadFileEntry record - #{msg} [#{arg}].")
        end
      elsif  (arg =~ exp)  
         raise ArgumentError.new("LoadFile::LoadFileEntry record - #{msg} [#{arg}].")
      else
        true
      end
    end
    # initialize and call setters for validation
    def initialize(control_number:, volume:, image_path:)
      self.control_number = control_number
      self.volume         = volume
      self.image_path     = image_path
    end

    # Determine equality of a LoadFileEntry by comparing equality of the control number, volume and
    # image path
    #
    # @param other [LoadFileEntry] a LoadFileEntry to compare equality with the receiver
    # @return [true, false] true if the LoadFileEntries are equal, false otherwise
    def ==(other)
      case other
      when LoadFileEntry
        control_number == other.control_number &&
          volume == other.volume &&
          image_path == other.image_path
      else
        false
      end
    end
  end
end