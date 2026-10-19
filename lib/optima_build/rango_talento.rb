module OptimaBuild
  class RangoTalento
    attr_reader :actual, :maximo

    def initialize(actual:, maximo:)
      raise ArgumentError, "El rango máximo debe ser mayor que cero" if maximo <= 0
      raise ArgumentError, "El rango actual no puede ser negativo" if actual < 0
      raise ArgumentError, "El rango actual no puede superar el máximo" if actual > maximo

      @actual = actual
      @maximo = maximo
    end
  end
end