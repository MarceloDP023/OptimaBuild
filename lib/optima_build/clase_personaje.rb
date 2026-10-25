# frozen_string_literal: true

require_relative 'arbol_talentos'

module OptimaBuild
  class ClasePersonaje
    attr_reader :id

    def initialize(id:, nombre:, arbol_talentos:)
      raise ArgumentError, 'El identificador de la clase debe ser un número entero' unless id.is_a?(Integer)

      raise ArgumentError, 'El nombre de la clase debe ser una cadena de texto' unless nombre.is_a?(String)

      raise ArgumentError, 'La clase debe tener un nombre' if nombre.empty?

      raise ArgumentError, 'El árbol debe ser un ArbolTalentos' unless arbol_talentos.is_a?(ArbolTalentos)

      @id = id
      @nombre = nombre
      @arbol_talentos = arbol_talentos
    end

    def ==(other)
      other.is_a?(ClasePersonaje) && id == other.id
    end

    alias eql? ==

    def hash
      [self.class, id].hash
    end

    def talento(talento_id)
      @arbol_talentos.talento(talento_id)
    end
  end
end
