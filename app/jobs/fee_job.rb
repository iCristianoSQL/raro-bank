class FeeJob < ApplicationJob
    queue_as :default
    
    def perform
        @indexers = [
            {
                name: "CDI",
                method: "get_cdi_rate"
            },
            {
                name: "SELIC",
                method: "get_selic_rate"
            },
            {
                name: "IPCA",
                method: "get_ipca_rate"
            }
        ]
        @indexers.each do |indexer|
            data = Indexers.send(indexer[:method])

            puts "passou aqui"

            if data.present?
                begin
                    fee = Fee.find_by_name(indexer[:name])
                    fee.update!(value: data.last["valor"], latest_release: data.last["data"])
                rescue ActiveRecord::RecordInvalid => e
                    puts "#{indexer['name']}: #{e.message}"
                end
            else
                puts "#{indexer[:name]}: Dados não disponíveis"
            end
        end
    end
end