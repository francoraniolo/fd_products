require_relative 'lib/app'
require_relative 'lib/static_files'
require 'puma'

Dir[File.join(__dir__, 'lib/jobs', '*.rb')].each { |file| require file }

#Para habilitar compresion gzip
use Rack::Deflater

use StaticFiles
run API.new
