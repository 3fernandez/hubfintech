class ApplicationService
  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
