
require 'factory_bot_rails'

10.times do
  FactoryBot.create(:gym)
end

puts "Academias cadastradas com sucesso!"
