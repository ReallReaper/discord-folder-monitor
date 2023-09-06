require 'listen'
require 'pathname'

# Obtiene la ruta del perfil de usuario actual
user_profile = ENV['USERPROFILE']

# Ruta a la carpeta Discord dentro del perfil de usuario
folder_path = File.join(user_profile, 'AppData', 'Local', 'Discord')

listener = Listen.to(folder_path) do |modified, added, removed|
  unless added.empty?
    puts "Archivos creados:"
    added.each { |file| puts "  - #{file}" }
  end

  unless removed.empty?
    puts "Archivos eliminados:"
    removed.each { |file| puts "  - #{file}" }
  end
end

puts "Monitoreando la carpeta: #{folder_path}"
listener.start

# Mantén el programa en funcionamiento hasta que el usuario presione Enter
puts "Presiona Enter para detener el monitoreo..."
gets

listener.stop
