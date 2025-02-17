require 'sidekiq'
require_relative '../db'
require_relative '../sidekiq_config'

module Jobs
  class ProductCreationJob
    include Sidekiq::Worker

    def perform(name)
      #Simulo creación del producto
      sleep(5)

      DB[:products].insert(name: name)
      puts "Product '#{name}'"
    end
  end
end
