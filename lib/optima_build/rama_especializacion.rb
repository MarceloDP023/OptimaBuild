# frozen_string_literal: true

require_relative 'talento'

module OptimaBuild
  class RamaEspecializacion
    attr_reader :id, :nombre, :talentos

    def initialize(id:, nombre:, talentos:)
      raise ArgumentError, 'El identificador de la rama debe ser un número entero' unless id.is_a?(Integer)

      raise ArgumentError, 'El nombre de la rama debe ser una cadena de texto' unless nombre.is_a?(String)

      raise ArgumentError, 'La rama debe tener un nombre' if nombre.empty?

      raise ArgumentError, 'Los talentos deben proporcionarse en un Array' unless talentos.is_a?(Array)

      talentos.each do |talento|
        raise ArgumentError, 'Todos los elementos de la rama deben ser talentos' unless talento.is_a?(Talento)
      end

      @id = id
      @nombre = nombre
      @talentos = talentos
      
    end
  end
end
