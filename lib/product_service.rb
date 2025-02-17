require_relative 'jobs/product_creation_job'

class ProductService
  def self.create_product(name)
    Jobs::ProductCreationJob.perform_async(name)
  end
end
