# frozen_string_literal: true

module OptimaBuild
  class RangoTalento
    attr_reader :actual, :maximo

    def initialize(actual:, maximo:)
      raise ArgumentError, 'El rango actual debe ser un número entero' unless actual.is_a?(Integer)
      raise ArgumentError, 'El rango máximo debe ser un número entero' unless maximo.is_a?(Integer)

      raise ArgumentError, 'El rango actual no puede ser negativo' if actual.negative?

      raise ArgumentError, 'El rango máximo debe ser mayor que cero' if maximo <= 0

      raise ArgumentError, 'El rango actual no puede superar el máximo' if actual > maximo

      @actual = actual
      @maximo = maximo
    end
  end
end
