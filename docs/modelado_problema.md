# Modelado del problema — OptimaBuild

## 1. Descripción del problema

OptimaBuild permite crear y gestionar configuraciones de talentos de personajes de un videojuego (Concretamente del WOW (world of warcraft)).

Cada personaje pertenece a una clase que determina su árbol de talentos. Este árbol se divide en tres ramas de especialización, cuyos talentos pueden desbloquearse mediante la asignación de puntos, respetando sus requisitos y rangos máximos.

El objetivo es facilitar la creación de configuraciones válidas y su optimización según el rol deseado.

## 2. Entidades

### Personaje
- **Identificador:** `idPersonaje`
- **Atributos:** nombre, nivel, clase, talentos asignados y rol objetivo.
- **Responsabilidad:** gestionar la configuración de talentos y garantizar que la distribución de puntos sea válida.

### ClasePersonaje
- **Identificador:** `idClase`
- **Atributos:** nombre, descripción y árbol de talentos.
- **Responsabilidad:** determinar el árbol de talentos disponible para los personajes de esa clase.

### RamaEspecializacion
- **Identificador:** `idRama`
- **Atributos:** nombre y conjunto de talentos.
- **Responsabilidad:** organizar los talentos de una especialización.

### Talento
- **Identificador:** `idTalento`
- **Atributos:** nombre, descripción, rango máximo, posición y requisitos.
- **Responsabilidad:** representar una habilidad que puede desbloquearse o mejorarse.

## 3. Objetos de valor

### RangoTalento
Representa los puntos asignados a un talento y su rango máximo permitido.

### PosicionTalento
Define la posición de un talento dentro de su rama mediante fila y columna.

### RequisitosTalento
Establece las condiciones necesarias para desbloquear un talento, como puntos mínimos invertidos o talentos previos.

### RolObjetivo
Representa el rol que se desea priorizar al construir una configuración.

## 4. Agregados

### Agregado Personaje
- **Raíz:** `Personaje`.
- Gestiona la distribución de puntos y garantiza la validez de la configuración.
- Consulta las definiciones de talentos asociadas a su clase.

### Agregado ClasePersonaje
- **Raíz:** `ClasePersonaje`.
- Contiene la definición del árbol de talentos, sus ramas y talentos.
- Garantiza la coherencia de la estructura del árbol.

## 5. Fuente única de verdad (SSOT)

Para evitar inconsistencias:

- La definición de los talentos se mantiene en el árbol asociado a `ClasePersonaje`.
- Los puntos asignados se almacenan en la configuración de cada `Personaje`.
- Los puntos gastados y restantes se calculan a partir de la distribución y de los puntos disponibles.
- Los requisitos y rangos máximos se consultan desde la definición de cada talento.
