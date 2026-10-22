# frozen_string_literal: true

require_relative 'arbol_talentos'

module OptimaBuild
  class ClasePersonaje
    attr_reader :id, :nombre, :arbol_talentos

    def initialize(id:, nombre:, arbol_talentos:)
      raise ArgumentError, 'El ID de la clase no puede estar vacío' if id.nil? || (id.respond_to?(:empty?) && id.empty?)

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
  end
end
