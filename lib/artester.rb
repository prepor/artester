require 'rubygems'

require 'active_record'
require 'active_support'



module Artester
  require 'artester/base'
  require 'artester/model'
  class << self
    
    def init
      ActiveRecord::Base.logger = Logger.new(STDOUT) # File.dirname(__FILE__) + "/debug.log"
      ActiveRecord::Base.establish_connection(config)
    end
    
    def config
      { 'adapter'  => 'sqlite3',
        'database' => 'memory'}
    end
    
    def def(name, &block)
      artesters[name.to_sym] = block
    end
    
    def artesters
      @@artesters ||= {}
    end
    
    def [](name)
      Artester::Base.new(name, &artesters[name])
    end
    
  end
  
end