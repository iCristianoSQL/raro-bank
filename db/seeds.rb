require 'json'

json_indexers = File.read(Rails.root.join('db', 'indexers.json'))
data = JSON.parse(json_indexers)
indexers = data['indexers']

json_products = File.read(Rails.root.join('db', 'products.json'))
products = JSON.parse(json_products)

json_users = File.read(Rails.root.join('db', 'users.json'))
users = JSON.parse(json_users)

puts "Iniciando seed"

#Adicionando indexadores no banco
  indexers.each do |indexer|
      data = Indexers.send(indexer['method'])
      
      if data.present?
        begin
          Fee.create!(name: indexer['name'], value: data.last['valor'], latest_release: data.last['data'])
          puts "Indexador #{indexer['name']} adicionado com sucesso!"
        rescue ActiveRecord::RecordInvalid => e
          puts "#{indexer['name']}: #{e.message}"
        end
      else
        puts "#{indexer[:name]}: Dados não disponíveis"
      end
  end

  #Adicionando produtos no banco
  products.each do |product_data|
    product_data['end_of_term'] = Date.today.advance(years: 1) + rand(365)
    product_data['fee'] = Fee.order("RANDOM()").first

    begin
      Product.create!(product_data)
      puts "Produto #{product_data['name']} adicionado com sucesso!"
    rescue ActiveRecord::RecordInvalid => e
      puts "#{product_data['name']}: #{e.message}"
    end
  end

  #Adicionando usuarios no banco
  users.each do |user_data|
    User.create!(
      name: user_data['name'],
      cpf: user_data['cpf'],
      email: user_data['email'],
      password: user_data['password']
    )
    puts "Usuário #{user_data['name']} adicionado com sucesso!"
  rescue ActiveRecord::RecordInvalid => e
    puts "#{user_data['name']}: #{e.message}"
  end

  puts "Todos os usuários foram autenticados com sucesso."
  User.update_all(confirmed_at: Time.now)

  admin_1 = User.find_by_name("Paulo Fernandes")
  admin_2 = User.find_by_name("Guilherme Andrade")

  puts "RaroRuby Class criada com sucesso"
  Classroom.create(name: "RaroRubyClass")

  puts "Administrador #{admin_1.name} adicionado com sucesso"
  Administrator.create(user: admin_1, classroom: Classroom.first)

  puts "Administrador #{admin_2.name} adicionado com sucesso"
  Administrator.create(user: admin_2, classroom: Classroom.first)

  puts "100k Pauloeda$ adicionadas com sucesso ao administrador #{admin_1.name}"
  admin_1.balance.update!(current_balance: 100_000.00)

  puts "100k Pauloeda$ adicionadas com sucesso ao administrador #{admin_2.name}"
  admin_2.balance.update!(current_balance: 100_000.00)

puts "Finalizou o seed"