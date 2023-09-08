
require 'factory_bot_rails'

# Crie 10 ginásios usando a factory
10.times do
  FactoryBot.create(:gym)
end

puts "Academias cadastradas com sucesso!"
