La HU001 plantea la necesidad de ayudar a un jugador que acaba de desbloquear su primer punto de talento a decidir cómo invertirlo en función del rol que quiere desempeñar.

Para poder abordar este problema se ha realizado un modelado inicial del dominio siguiendo DDD, identificando los conceptos principales, sus relaciones y las restricciones que deben mantenerse.

Este issue reúne las decisiones tomadas en los distintos issues derivados de HU001 y sirve como visión conjunta del modelo correspondiente al Milestone 0.

---

## Criterios de modelado

Para realizar el modelo se han seguido los siguientes criterios:

- **Entidad**: concepto con identidad propia cuyo estado puede evolucionar durante su ciclo de vida.
- **Objeto valor**: concepto definido por sus datos y que no necesita identidad propia.
- **Agregado**: conjunto de entidades y objetos valor que deben mantenerse coherentes como una unidad.
- Los objetos del dominio deben impedir, en la medida de lo posible, que puedan construirse estados inválidos.
- Al utilizar Ruby, los constructores comprueban explícitamente los tipos de los datos recibidos.
- Las relaciones entre conceptos solo aceptan objetos del tipo de dominio esperado.
- Se aplica el principio **SSOT (Single Source of Truth)** para evitar mantener información duplicada que pueda quedar desincronizada.
- Los valores que pueden calcularse a partir del estado existente se derivan en lugar de almacenarse de forma redundante.
- No se añaden identificadores artificiales cuando no son necesarios dentro del dominio.

---

## Modelo general

```text
Personaje
├── ClasePersonaje
│   └── ArbolTalentos
│       ├── RamaEspecializacion
│       │   └── Talento
│       │       ├── RangoTalento
│       │       ├── PosicionTalento
│       │       └── RequisitosTalento
│       ├── RamaEspecializacion
│       └── RamaEspecializacion
├── Nivel
└── RolObjetivo
```

## Clasificación DDD de los conceptos

Durante el análisis de HU001 se han identificado los conceptos del dominio y se han clasificado como **entidades**, **objetos valor** y **agregados**.

La clasificación se ha realizado atendiendo a si el concepto necesita conservar una identidad propia, si queda definido únicamente por sus valores y qué objetos deben mantenerse coherentes como una unidad.

### Entidades

#### `Personaje`

`Personaje` se identifica como una **entidad**.

Dos personajes pueden pertenecer a la misma clase, tener el mismo nivel, el mismo rol y una distribución idéntica de talentos, pero siguen representando personajes diferentes dentro del dominio.

Además, su estado evoluciona durante la progresión.

Mantiene:

- La clase a la que pertenece.
- Su nivel actual.
- Su rol objetivo.

Los puntos de talento disponibles no se almacenan directamente, sino que se calculan a partir del nivel y de los puntos ya invertidos.

`Personaje` actúa además como **raíz del agregado principal** del modelo.

#### `Talento`

`Talento` se identifica como una **entidad**.

Cada talento representa un elemento concreto dentro del árbol y dispone de un identificador que permite distinguirlo del resto.

Su estado puede cambiar durante la progresión, principalmente mediante su rango actual, pero continúa representando el mismo talento.

Mantiene:

- Identificador.
- Nombre.
- `RangoTalento`.
- `PosicionTalento`.
- `RequisitosTalento`.

#### `RamaEspecializacion`

`RamaEspecializacion` se identifica como una **entidad**.

Cada rama representa una especialización concreta dentro del árbol de talentos.

Mantiene:

- Identificador.
- Nombre.
- Conjunto de talentos.

La rama actúa como fuente de verdad sobre los talentos que contiene.

---

### Objetos valor

#### `RangoTalento`

`RangoTalento` se identifica como un **objeto valor**.

No necesita identidad propia. Lo relevante son sus valores:

- Rango actual.
- Rango máximo.

Debe cumplirse:

```text
0 <= rango_actual <= rango_maximo
rango_maximo > 0