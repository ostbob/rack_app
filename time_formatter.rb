class TimeFormatter
  attr_reader :known_formats, :unknown_formats, :unknown_string, :known_string

  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  def initialize(formats_string)
    @known_formats = []
    @unknown_formats = []

    formats_string.split(',').each do |format|
      if FORMATS.key?(format.to_sym)
        @known_formats << FORMATS[format.to_sym]
      else
        @unknown_formats << format
      end
    end

    @unknown_string = unknown_formats.join(',')
    @known_string = known_formats.join('-')
  end
end
