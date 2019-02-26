namespace :dev do
  desc "Configura o ambiente de desenvolvimento."
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping DB...","Dropped successfully!") { %x(rails db:drop) }
      show_spinner("Create DB...","Created successfully!") { %x(rails db:create) }
      show_spinner("Migrating DB...","Migrated successfully!") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
      
    else
      puts "You are not in development mode!"
    end   
  end
  
  
  desc "Cadastrar moedas"
  task add_coins: :environment do 
    show_spinner("Create coins...","Created successfully!") do
      coins = [
        { 
          description: "Biticoin",
          acronym: "BTC",
          url_image: "https://usethebitcoin.com/wp-content/uploads/2018/07/bitcoin_PNG47.png",
          mining_type: MiningType.find_by(acronym: "PoW")
        },
        { 
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png",
          mining_type: MiningType.find_by(acronym: "PoW")
        },
        {
          description: "Dash",
          acronym: "DASH",
          url_image: "http://cryptowiki.net/images/5/55/Dash.png",
          mining_type: MiningType.all.sample
        }
      ]
      
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Cadastrar tipos de moedas"
  task add_mining_types: :environment do
    show_spinner("Create mining types...","Created successfully!") do
      mining_types = [
        { description: "Prook of Work", acronym: "PoW" },
        { description: "Prook of Stake", acronym: "PoS" },
        { description: "Prook of Capacity", acronym: "PoC" },
      ]
      mining_types.each do |mining_types|
        MiningType.find_or_create_by!(mining_types)
      end
    end
  end
  
  private
  
  def show_spinner(msg_start, msg_end)
    
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}") #bouncing_ball
    spinner.auto_spin
    yield
    spinner.success ("#{msg_end}")
  end
end