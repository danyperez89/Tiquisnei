# encoding: UTF-8
require 'drb'
require './juego'

class Sala
  attr_accessor :jugadores, :tableros, :solos
  
  def initialize
    @jugadores = []
    @tableros = {}
    @solos = []    
  end
  
  def login(njugador) 
    @jugadores << njugador
    @solos << njugador #ingresar al arreglo
    log("LOGIN DE #{njugador.name}")
    if @solos.size >= 2
      iniciar_juego(@solos[0], @solos[1])
    end
  end

  def logout(njugador)
    log("LOGOUT DE #{njugador.name}")
    @jugador.delete(njugador)
    @solos.delete(njugador)
  end
  
  def iniciar_juego(jugador0, jugador1)
    @solos.delete(jugador0)
    @solos.delete(jugador1)
    log("Iniciando juego #{jugador0.name}   #{jugador1.name}")
    juego = Juego.new(jugador0, jugador1)
    jugador0.pintar_tablero(juego.pintar_tablero)
    jugador1.pintar_tablero(juego.pintar_tablero)
    
    jugador1.iniciar_juego(juego, false)
    jugador0.iniciar_juego(juego, true)
  end
  
  def jugadas(juagdor, fila, columna)
    juego.jugar(jugador, fila, columna)
  end
  
  
  def log(mensaje)
    $stderr.puts "[SERVIDOR #{DRb.uri} #{Time.now.strftime("On %D at %I:%M%p")}] #{mensaje}"
  end
  
  
end



game_lobby = Sala.new

DRb.start_service "druby://dany-perez.local:54419", game_lobby
puts "Sala started at #{DRb.uri}"
DRb.thread.join