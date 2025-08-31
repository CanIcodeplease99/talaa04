if defined?(Sidekiq)
  require 'sidekiq/cron/job'
  Sidekiq::Cron::Job.create(name:'Rail health ping', cron:'*/1 * * * *', class:'RailHealthWorker')
end
