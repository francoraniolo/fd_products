# db.rb
require 'sequel'

DB ||= Sequel.connect('postgres://franco:franco123@db/fudoproducts')

unless DB.table_exists?(:products)
  DB.create_table :products do
    primary_key :id
    String :name
  end
end
