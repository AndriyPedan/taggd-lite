class BaseService
  def initialize(opts = {})
    opts.each do |name, value|
      instance_variable_set("@#{name}", value)
      self.class.send(:attr_reader, name)
    end
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
