# frozen_string_literal: true

require_relative 'clase_personaje'

module OptimaBuild
  class Personaje
    ROLES_VALIDOS = %i[tanque sanador dps].freeze
    attr_reader :clase, :nivel, :rol_objetivo

    def initialize(clase:, nivel:, rol_objetivo:)
      raise ArgumentError, 'La clase debe ser una ClasePersonaje' unless clase.is_a?(ClasePersonaje)

      raise ArgumentError, 'El nivel debe ser un número entero' unless nivel.is_a?(Integer)

      raise ArgumentError, 'El nivel debe estar entre 10 y 60' if nivel < 10 || nivel > 60

      raise ArgumentError, 'El rol debe ser un símbolo' unless rol_objetivo.is_a?(Symbol)

      raise ArgumentError, 'El rol indicado no es válido' unless ROLES_VALIDOS.include?(rol_objetivo)

      @clase = clase
      @nivel = nivel
      @rol_objetivo = rol_objetivo
    end

    def puntos_talento_totales
      @nivel - 9
    end

    def puntos_invertidos
      @clase.arbol_talentos.ramas.sum(&:puntos_invertidos)
    end

    def puntos_talento_disponibles
      puntos_talento_totales - puntos_invertidos
    end
  end
end
