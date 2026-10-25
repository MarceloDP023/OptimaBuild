# frozen_string_literal: true

require_relative 'talento'

module OptimaBuild
  class RamaEspecializacion
    attr_reader :id

    def initialize(id:, nombre:, talentos:)
      raise ArgumentError, 'El identificador de la rama debe ser un número entero' unless id.is_a?(Integer)

      raise ArgumentError, 'El nombre de la rama debe ser una cadena de texto' unless nombre.is_a?(String)

      raise ArgumentError, 'La rama debe tener un nombre' if nombre.empty?

      raise ArgumentError, 'Los talentos deben proporcionarse en un Hash' unless talentos.is_a?(Hash)

      talentos.each do |id, talento|
        raise ArgumentError, 'El identificador del talento debe ser un número entero' unless id.is_a?(Integer)

        raise ArgumentError, 'Todos los elementos de la rama deben ser talentos' unless talento.is_a?(Talento)

        raise ArgumentError, 'La clave debe coincidir con el identificador del talento' unless id == talento.id
      end

      @id = id
      @nombre = nombre
      @talentos = talentos
    end

    def talento(talento_id)
      @talentos[talento_id]
    end
  end
end
