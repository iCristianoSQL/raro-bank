# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, "#{path}/log/cron.log"
set :environment, 'development'
env :PATH, ENV['PATH']

every 1.day do
  rake 'fees:update_fee_in_database'
end
every 1.day, at: '8:00 am' do
  rake 'fees:perform_daily_income_calculation'
end

every 1.day, at: '8:00 am' do
  rake 'fees:redeem_balance_at_the_end_of_the_date'
end

every 1.day, at: '8:00 am' do
  runner "TransferJob.perform_now"
end
