class RailHealthWorker
  include Sidekiq::Worker
  def perform
    map={'zeepay'=>Gateway::ZeepayClient.new, 'hubtel'=>Gateway::HubtelClient.new}
    map.each do |name, client|
      st=(client.health rescue 'down')
      Rails.cache.write("rail:gh:#{name}:status", st, expires_in: 120)
    end
  end
end
