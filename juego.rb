# encoding: UTF-8

require 'drb'

class Juego
  include DRbUndumped

  attr_accessor :jugador1, :jugador2, :numero_jugadores, :tablero

  def initialize(j1, j2)
    DRb.start_service
    @jugador1 = j1
    @jugador2 = j2
    @numero_jugadores = {j1.name => 'X', j2.name => 'O'}
    @tablero =  [
      ['A', 'B', 'C'],
      ['D', 'E', 'F'],
      ['G', 'H', 'I']
    ]
  end

  def to_s
    "Juego en URL #{DRb.uri}"
  end

  def say_whaa
    "Whaa"
  end

  def marcar_jugada(jugada, num)
    @tablero[jugada.first][jugada.last] = num
  end

  def ganador
    return a if a == b && a == c
    return d if d == e && d == f
    return g if g == h && g == i

    return a if a == d && a == g
    return b if b == e && b == h
    return c if c == f && c == i

    return a if a == e && a == i
    return c if c == e && c == g

    return nil
  end

  def pedir_oponente(nombre)
    return @jugador1 if @jugador1.name != nombre
    @jugador2
  end

  def turno(nombre, posicion)
    jugada = case posicion
    when 'A'
      [0,0]
    when 'B'
      [0,1]
    when 'C'
      [0,2]
    when 'D'
      [1,0]
    when 'E'
      [1,1]
    when 'F'
      [1,2]
    when 'G'
      [2,0]
    when 'H'
      [2,1]
    when 'I'
      [2,2]
    else
      puts "Comando No Valido Yordo"
    end

    marcar_jugada(jugada, @numero_jugadores[nombre])
    jg = ganador
    triqui = pintar_tablero

    unless jg.nil?
      triqui = "Ganó #{@numero_jugadores.key(jg)}\n\n#{triqui}"
    end
    
    pedir_oponente(pedir_oponente(nombre).name).pintar_tablero(triqui)
    return pedir_oponente(nombre).alerta_de_movida(triqui)
  end
  
  def pintar_tablero
    tablero = <<-BOARD
 ---------TRIQUI V.1.2 ®--------
Para ubicar solo escribe la letra 
  donde quieres poner tu jugada 
        y presiona enter
 _________________________________
|           |          |          |
|      #{a}    |    #{b}     |    #{c}     |
|           |          |          |
|___________|__________|__________|
|           |          |          |
|     #{d}     |    #{e}     |     #{f}    |
|           |          |          |
|___________|__________|__________|
|           |          |          |
|     #{g}     |     #{h}    |     #{i}    |
|           |          |          |
|___________|__________|__________|



   BOARD
   tablero
  end

  def to_s
    pintar_tablero
  end


  def a()  @tablero[0][0] ; end
  def b()  @tablero[0][1] ; end
  def c()  @tablero[0][2] ; end

  def d()  @tablero[1][0] ; end
  def e()  @tablero[1][1] ; end
  def f()  @tablero[1][2] ; end

  def g()  @tablero[2][0] ; end
  def h()  @tablero[2][1] ; end
  def i()  @tablero[2][2] ; end


end