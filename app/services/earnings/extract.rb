module Earnings
  class Extract
    def self.call(file, user)
      extractor = ::Extract::XLS::Earnings.new(file, user)
      extractor.call
      true
    rescue StandardError
      false
    end
  end
end
