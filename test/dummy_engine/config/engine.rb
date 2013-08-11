ENGINE_ROOT = File.expand_path('../../', __FILE__)
ENGINE_PATH = "#{ENGINE_ROOT}/lib/dummy_engine/engine"

GEM_ROOT = File.expand_path('../../', ENGINE_ROOT)

$LOAD_PATH.unshift("#{GEM_ROOT}/lib")
$LOAD_PATH.unshift("#{ENGINE_ROOT}/lib")

require 'dummy_engine'
