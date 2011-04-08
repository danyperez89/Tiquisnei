# encoding: UTF-8
require 'drb'

class Jugador
  include DRbUndumped
  
  attr_accessor :name, :sala, :juego
  
  def initialize(name, sala)
    @name = name
    @sala = sala
    @juego = nil
    @sala.login(self)
  end
  
  def iniciar_juego(juego, empiezo = false)
    @juego = juego
    #log("[Iniciar Juego] #{@juego.say_hello!}")
    return pedir_jugada if empiezo
  end
  
  def pedir_jugada
    puts "Introduce la letra donde quieras ubicar:"
    posicion = gets
    posicion = posicion.gsub!(/\n/, "").strip.upcase
    log(posicion)
    #log("[Pedir jugada juego] #{@juego.say_hello!}")
    tablero = @juego.turno(@name, posicion)
  end
  
  def alerta_de_movida(tablero)
    pintar_tablero(tablero)
    return pedir_jugada
  end
  
  def pintar_tablero(tablero)
    system 'clear'
    puts tablero
  end
  
  private
  
  def log(mensaje)
    $stderr.puts "[Jugador #{@name} #{Time.now.strftime("On %D at %I:%M%p")}] #{mensaje}"
  end
  
  
end




DRb.start_service
server_uri = ARGV.shift.to_s
server = DRbObject.new nil, server_uri
player = Jugador.new(ARGV.shift.to_s, server)
DRb.thread.join