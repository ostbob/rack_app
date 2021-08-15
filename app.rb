require_relative 'time_formatter'

class App

  def call(env)
    req = Rack::Request.new(env)

    if req.get? && req.path == '/time' && req.params['format'] != nil
      time_formatter = TimeFormatter.new(req.params['format'])

      if time_formatter.unknown_formats.any?
        response(400, 'Unknown time format [' + time_formatter.unknown_string + ']')
      else
        response(200, Time.now.strftime(time_formatter.known_string))
      end
    else
      response(404, '404 ERROR!\n')
    end
  end

  private

  def response(status, body)
    response = Rack::Response.new(
      [body],
      status,
      {'Content-Type' => 'text/plain'}
    )
    response.finish
  end
end
