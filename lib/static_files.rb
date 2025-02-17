require 'rack'

class StaticFiles
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    case request.path_info
    when "/openapi"
      serve_static_file("public/openapi.yaml", "application/yaml", "no-store")
    when "/authors"
      serve_static_file("public/AUTHORS", "text/plain", "max-age=86400")
    else
      @app.call(env)
    end
  end

  private

  def serve_static_file(file_path, content_type, cache_control)
    if File.exist?(file_path)
      [200, { "content-type" => content_type, "cache-control" => cache_control }, [File.read(file_path)]]
    else
      [404, { "content-type" => "application/json" }, [{ error: "File not found" }.to_json]]
    end
  end
end
