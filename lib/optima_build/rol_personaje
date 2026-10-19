module OptimaBuild
  class RolObjetivo
    ROLES_VALIDOS = [:tanque, :sanador, :dps].freeze

    attr_reader :nombre

    def initialize(nombre:)
      unless nombre.is_a?(Symbol)
        raise ArgumentError, 'El rol debe ser un símbolo'
      end

      unless ROLES_VALIDOS.include?(nombre)
        raise ArgumentError, 'El rol indicado no es válido'
      end

      @nombre = nombre
    end
  end
end