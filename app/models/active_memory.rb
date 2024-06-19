class ActiveMemory
  include ActiveModel::Model
  include ActiveModel::Validations

  class << self
    def create(attrs); end

    def find(id); end

    def all(id); end
  end
end
