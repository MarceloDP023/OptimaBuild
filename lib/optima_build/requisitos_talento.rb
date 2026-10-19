# frozen_string_literal: true

module OptimaBuild
  class RequisitosTalento
    attr_reader :puntos_rama, :talento_requerido_id, :rango_requerido

    def initialize(puntos_rama: 0, talento_requerido_id: nil, rango_requerido: nil)
      unless puntos_rama.is_a?(Integer)
        raise ArgumentError,
              'Los puntos requeridos en la rama deben ser un número entero'
      end

      if !talento_requerido_id.nil? && !talento_requerido_id.is_a?(Integer)
        raise ArgumentError, 'El identificador del talento requerido debe ser un número entero'
      end

      if !rango_requerido.nil? && !rango_requerido.is_a?(Integer)
        raise ArgumentError, 'El rango requerido debe ser un número entero'
      end

      raise ArgumentError, 'Los puntos requeridos en la rama no pueden ser negativos' if puntos_rama.negative?

      if talento_requerido_id.nil? && !rango_requerido.nil?
        raise ArgumentError, 'No puede existir un rango requerido sin un talento requerido'
      end

      if !rango_requerido.nil? && (rango_requerido <= 0)
        raise ArgumentError, 'El rango requerido debe ser mayor que cero'
      end

      @puntos_rama = puntos_rama
      @talento_requerido_id = talento_requerido_id
      @rango_requerido = rango_requerido
    end
  end
end
