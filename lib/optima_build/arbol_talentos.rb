# frozen_string_literal: true

require_relative 'rama_especializacion'

module OptimaBuild
  class ArbolTalentos
    def initialize(ramas:)
      raise ArgumentError, 'Las ramas deben proporcionarse en un Hash' unless ramas.is_a?(Hash)

      raise ArgumentError, 'Un árbol de talentos debe tener exactamente tres ramas' unless ramas.length == 3

      ramas.each do |rama_id, rama|
        raise ArgumentError, 'El identificador de la rama debe ser un número entero' unless rama_id.is_a?(Integer)

        unless rama.is_a?(RamaEspecializacion)
          raise ArgumentError, 'Todos los elementos del árbol deben ser ramas de especialización'
        end

        raise ArgumentError, 'La clave debe coincidir con el identificador de la rama' unless rama_id == rama.id
      end

      ids_talentos = ramas.values.flat_map(&:ids_talentos)

      if ids_talentos.uniq.length != ids_talentos.length
        raise ArgumentError, 'Un identificador de talento no puede repetirse entre ramas'
      end

      @ramas = ramas
    end

    def talento(talento_id)
      @ramas.each_value do |rama|
        talento = rama.talento(talento_id)
        return talento unless talento.nil?
      end

      nil
    end
  end
end
