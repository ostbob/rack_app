class App

  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  def call(env)
    req = Rack::Request.new(env)

    @known_formats = []
    @unknown_formats = []

    if req.get? && req.path == '/time' && req.params['format'] != nil
      req.params['format'].split(',').each do |format|
        if FORMATS.key?(format.to_sym)
          @known_formats << FORMATS[format.to_sym]
        else
          @unknown_formats << format
        end
      end

      if @unknown_formats.any?
        response_400
      else
        response_200
      end
    else
      response_404
    end

    [@status, {'Content-Type' => 'text/plain'}, [@body]]
  end

  private

  def response_404
    @status = 404
    @body = '404 ERROR!\n'
  end

  def response_200
    @status = 200
    @body = Time.now.strftime(@known_formats.join('-'))
  end

  def response_400
    @status = 400
    @body = 'Unknown time format [' + @unknown_formats.join(',') + ']'
  end

end
