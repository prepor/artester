class Base
  attr_accessor :name, :models
  def initialize(name, &block)
    self.name = name.to_s
    self.models = {}
    instance_eval(&block)
  end
  
  def model(name, &block)
    self.models[name.to_sym] = Artester::Model.new(name, &block)
  end
  
  def reload
    self.models.each { |name, m| m.reload }
  end
end