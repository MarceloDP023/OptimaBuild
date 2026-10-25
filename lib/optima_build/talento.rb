# frozen_string_literal: true

require_relative 'posicion_talento'
require_relative 'requisitos_talento'

module OptimaBuild
  class Talento
    attr_reader :id,

    def initialize(id:, nombre:, rango_maximo:, posicion:, requisitos:)
      raise ArgumentError, 'El identificador del talento debe ser un número entero' unless id.is_a?(Integer)

      raise ArgumentError, 'El nombre del talento debe ser una cadena de texto' unless nombre.is_a?(String)

      raise ArgumentError, 'El talento debe tener un identificador' if id.nil?

      raise ArgumentError, 'El talento debe tener un nombre' if nombre.nil? || nombre.empty?

      raise ArgumentError, 'El rango máximo debe ser un número entero' unless rango_maximo.is_a?(Integer)

      raise ArgumentError, 'El rango máximo debe ser mayor que cero' if rango_maximo <= 0

      raise ArgumentError, 'La posición debe ser una PosicionTalento' unless posicion.is_a?(PosicionTalento)

      raise ArgumentError, 'Los requisitos deben ser un RequisitosTalento' unless requisitos.is_a?(RequisitosTalento)

      @id = id
      @nombre = nombre
      @rango_maximo = rango_maximo
      @posicion = posicion
      @requisitos = requisitos
    end
  end
end
