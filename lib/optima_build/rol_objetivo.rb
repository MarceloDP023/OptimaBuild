# frozen_string_literal: true

module OptimaBuild
  class RolObjetivo
    ROLES_VALIDOS = %i[tanque sanador dps].freeze

    attr_reader :nombre

    def initialize(nombre:)
      raise ArgumentError, 'El rol debe ser un símbolo' unless nombre.is_a?(Symbol)

      raise ArgumentError, 'El rol indicado no es válido' unless ROLES_VALIDOS.include?(nombre)

      @nombre = nombre
    end
  end
end
