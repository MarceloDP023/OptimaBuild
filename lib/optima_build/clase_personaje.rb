# frozen_string_literal: true

require_relative 'arbol_talentos'

module OptimaBuild
  class ClasePersonaje
    attr_reader :id, :nombre, :arbol_talentos

    def initialize(nombre:, arbol_talentos:)
      raise ArgumentError, 'El nombre de la clase debe ser una cadena de texto' unless nombre.is_a?(String)

      raise ArgumentError, 'La clase debe tener un nombre' if nombre.empty?

      raise ArgumentError, 'El árbol debe ser un ArbolTalentos' unless arbol_talentos.is_a?(ArbolTalentos)

      @nombre = nombre
      @arbol_talentos = arbol_talentos
    end
  end
end
