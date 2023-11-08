namespace :fees do
    desc 'Update fee in database'
    task update_fee_in_database: :environment do
        FeeJob.perform_now
    end

    desc 'Perform daily income calculation'
    task perform_daily_income_calculation: :environment do
      DailyIncomeJob.perform_now
    end

    desc 'redeem_balance_at_the_end_of_the_date'
    task redeem_balance_at_the_end_of_the_date: :environment do
      EndOfTermJob.perform_now
    end
end