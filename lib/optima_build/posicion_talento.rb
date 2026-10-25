# frozen_string_literal: true

module OptimaBuild
  class PosicionTalento

    def initialize(fila:, columna:)
      raise ArgumentError, 'La columna debe ser un número entero' unless columna.is_a?(Integer)
      raise ArgumentError, 'La fila debe ser un número entero' unless fila.is_a?(Integer)

      raise ArgumentError, 'La fila no puede ser negativa' if fila.negative?

      raise ArgumentError, 'La columna no puede ser negativa' if columna.negative?

      @fila = fila
      @columna = columna
    end
  end
end
