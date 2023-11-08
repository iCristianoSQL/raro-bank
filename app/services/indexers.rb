class Indexers
    def self.get_cdi_rate
      response = Faraday.get('https://api.bcb.gov.br/dados/serie/bcdata.sgs.12/dados/ultimos/1?formato=json')
      data = JSON.parse(response.body)
    end

    def self.get_selic_rate
      response = Faraday.get('https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados/ultimos/1?formato=json')
      data = JSON.parse(response.body)
    end

    def self.get_ipca_rate
      response = Faraday.get('https://api.bcb.gov.br/dados/serie/bcdata.sgs.10844/dados/ultimos/1?formato=json')
      data = JSON.parse(response.body)
    end
  end