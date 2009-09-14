module Artester
  class Model
    attr_accessor :name, :definition_block, :klass_block
    def initialize(name, &block)
      self.name = name.to_s
      instance_eval(&block)
    end
  
    def definition(&block)
      self.definition_block = block
    end
  
    def klass(&block)
      self.klass_block = block
    end
  
  
    def reload
      ActiveRecord::Base.connection.create_table(name.tableize, :force => true, &definition_block)
    
      Object.send(:remove_const, name.classify) rescue nil
      Object.const_set(name.classify, Class.new(ActiveRecord::Base))
      name.classify.constantize.class_eval(&klass_block) if klass_block
    
    end
  end
end