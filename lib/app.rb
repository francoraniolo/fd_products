require 'rack'
require 'json'
require 'sidekiq'
require_relative 'auth'
require_relative 'product_service'
require 'sequel'
require_relative 'db'

class API
  def call(env)
    req = Rack::Request.new(env)

    case [req.request_method, req.path]
    when ['POST', '/auth']
      handle_auth(req)
    when ['POST', '/products']
      handle_create_product(req)
    when ['GET', '/products']
      handle_get_products(req)
    else
      response(404, { error: 'Not found' })
    end
  end

  private

  def handle_auth(req)
    data = JSON.parse(req.body.read) rescue {}
    token = Auth.authenticate(data['user'], data['password'])
    token ? response(200, { token: token }) : response(401, { error: 'Unauthorized' })
  end

  def handle_create_product(req)
    return response(401, { error: 'Unauthorized' }) unless Auth.authorized?(req)

    data = JSON.parse(req.body.read) rescue {}
    if data['name']
      ProductService.create_product(data['name'])
      response(202, { message: 'Product creation in progress' })
    else
      response(400, { error: 'Missing product name' })
    end
  end

  def handle_get_products(req)
    return response(401, { error: 'Unauthorized' }) unless Auth.authorized?(req)

    products = DB[:products].all
    response(200, products)
  end

  def response(status, body)
    [
      status,
      { 'content-type' => 'application/json' },
      [body.to_json]
    ]
  end
end
