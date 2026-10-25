# frozen_string_literal: true

require_relative 'clase_personaje'

module OptimaBuild
  class Personaje
    ROLES_VALIDOS = %i[tanque sanador dps].freeze

    attr_reader :id

    def initialize(id:, clase:, nivel:, rol_objetivo:, progreso_talentos: {})
      raise ArgumentError, 'El identificador del personaje debe ser un número entero' unless id.is_a?(Integer)

      raise ArgumentError, 'La clase debe ser una ClasePersonaje' unless clase.is_a?(ClasePersonaje)

      raise ArgumentError, 'El nivel debe ser un número entero' unless nivel.is_a?(Integer)

      raise ArgumentError, 'El nivel debe estar entre 10 y 60' if nivel < 10 || nivel > 60

      raise ArgumentError, 'El rol debe ser un símbolo' unless rol_objetivo.is_a?(Symbol)

      raise ArgumentError, 'El rol indicado no es válido' unless ROLES_VALIDOS.include?(rol_objetivo)

      raise ArgumentError, 'El progreso debe proporcionarse en un Hash' unless progreso_talentos.is_a?(Hash)

      progreso_talentos.each do |talento_id, rango_actual|
        unless talento_id.is_a?(Integer)
          raise ArgumentError, 'El identificador del talento debe ser un número entero'
        end

        raise ArgumentError, 'El rango actual debe ser un número entero' unless rango_actual.is_a?(Integer)

        raise ArgumentError, 'El rango actual no puede ser negativo' if rango_actual.negative?
      end

      @id = id
      @clase = clase
      @nivel = nivel
      @rol_objetivo = rol_objetivo
      @progreso_talentos = progreso_talentos
    end

    def puntos_talento_totales
      @nivel - 9
    end

    def puntos_invertidos
      @progreso_talentos.values.sum
    end

    def puntos_talento_disponibles
      puntos_talento_totales - puntos_invertidos
    end
  end
end
