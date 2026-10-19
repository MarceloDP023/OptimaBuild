# frozen_string_literal: true

require_relative 'rama_especializacion'

module OptimaBuild
  class ArbolTalentos
    attr_reader :ramas

    def initialize(ramas:)
      raise ArgumentError, 'Las ramas deben proporcionarse en un Array' unless ramas.is_a?(Array)

      raise ArgumentError, 'Un árbol de talentos debe tener exactamente tres ramas' unless ramas.length == 3

      ramas.each do |rama|
        unless rama.is_a?(RamaEspecializacion)
          raise ArgumentError, 'Todos los elementos del árbol deben ser ramas de especialización'
        end
      end

      @ramas = ramas
    end
  end
end
