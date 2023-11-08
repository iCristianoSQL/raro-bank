class AkternativefeeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "OIiiiii"
  end
end
