# OptimaBuild
## Cliente
Un jugador habitual de World Of Warcraft Clásico con tiempo o conocimientos limitados

[Definición detallada de clientes tipo](./docs/clientes.md)

## Descripción del problema
Muchos jugadores de WoW Classic inician una partida con una clase en mente, pero cuando llega el momento de subir de nivel y elegir una habilidad de las que hay, la cosa se complica: que si esta es buena, que si la otra es mejor pero en casos concretos, que si esta me da beneficios instantáneos... , un comedero de cabeza en general.

En este juego, cada una de las 9 clases a elegir tiene un árbol de habilidades dividido en 3 ramas dependiendo del rol que tomes de esa clase. Los jugadores reciben 1 punto de habilidad desde el nivel 10 hasta el 60, otorgando un total finito de 51 puntos, además de que el árbol impone restricciones como haber invertido 5 puntos en una rama para desbloquear la siguiente fila o haber aprendido previamente una habilidad concreta. Esto hace que la mayoría de jugadores se vean abrumados por la cantidad de talentos y reglas, y se vean obligados a escoger sin saber muy bien que hacen, llegando a veces a no poder seguir avanzando en el juego por haber elegido mal las habilidades y encontrarse con un bloqueo de progresión, optando al final por dejar de jugarlo o reiniciar otra partida y haber perdido todo ese tiempo.

Teniendo en cuenta que un jugador promedio dedica entre 7 y 10 horas semanales y que el bloqueo se suele detectar entre las 20 y 30 primeras horas, el problema representa la pérdida directa de unas 3 semanas completas de su tiempo. 

Para poder evaluar las combinaciones y calcular la ruta óptima sin que el usuario introduzca listas de habilidades o datos manualmente, la información sobre la estructura del árbol así como el contenido, las dependencias y las relaciones de los nodos se obtienen de volcados de datos en formato JSON extraídos de la versión 1.12 oficial del juego que se encuentran en repositorios públicos de GitHub.

### Repositorio con los datos necesarios
https://github.com/iamadagostino/wow-classic-talent-calculator/blob/master/assets/data/talent-data.json

## Lógica de negocio
El problema radica en la necesidad de determinar con antelación una ruta de puntos de habilidades viable y eficiente para una clase y especialización concretas, calculando y evaluando secuencias de progresión que maximicen la viabilidad del personaje según el presupuesto de niveles disponible sin atravesar valles críticos de debilidad.

Dado que el juego impone dependencias para talentos y umbrales por fila (5 puntos para desbloquear la siguiente fila) sobre el árbol de habilidades, el sistema actúa como motor de cálculo y validación, siendo responsabilidad del desarrollador diseñar la función heurística de evaluación que decida entre múltiples caminos legales válidos. 

Una ruta se evalúa como superior a otra aplicando los siguientes **criterios basados en los datos disponibles**:

1. **Profundización frente a dispersión (Eficiencia de fila):** Minimizar los niveles invertidos para alcanzar las filas avanzadas (tier 5 y tier 6) de la rama principal del rol. Una ruta que desbloquea talentos mayores en los niveles mínimos teóricos (por ejemplo, alcanzar la fila 6 al nivel 40 invirtiendo exactamente 30 puntos en la rama) es superior a una ruta dispersa que reparte puntos en ramas secundarias sin abrir niveles superiores.
2. **Eliminación de puntos muertos (Mitigación de valles de debilidad):** Penalizar las inversiones en nodos de utilidad situacional durante la fase intermedia de subida de nivel. La heurística priorizará nodos que aporten escalado constante o habilidades activas de uso recurrente en combate frente a talentos de probabilidad baja o pasivas marginales de relleno.
3. **Continuidad de la cadena de prerrequisitos:** Minimizar la latencia entre el cumplimiento de una dependencia y la activación del nodo dependiente. Si una habilidad clave exige 5 puntos en un nodo predecesor, la secuencia debe priorizar completar ese requisito sin intercalar puntos en nodos no relacionados, evitando que el personaje pase niveles sin beneficio acumulativo.
4. **Respeto estricto del presupuesto por nivel:** Garantizar que en cada nivel individual (del 10 al 60) la asignación realizada es válida tanto respecto al umbral acumulado de rama como a las dependencias de habilidades previas, asegurando que no existan retrocesos ni estados temporales ilegales.
5. **Alineación con el rol declarado:** Maximizar el peso de los nodos pertenecientes a la rama primaria asignada al rol (por ejemplo, daño sostenido frente a soporte), evaluando si el conjunto de habilidades activadas al nivel 60 concentra al menos el grueso del presupuesto de 51 puntos en la especialización objetivo.

## Lenguaje de programación

El proyecto se implementa en **Ruby**.

La elección se basa en las necesidades del dominio que se está modelando. OptimaBuild trabaja principalmente con entidades y objetos que mantienen un conjunto reducido de datos y deben garantizar determinadas invariantes durante su creación y relación entre ellos.

Ruby permite representar este modelo de forma directa mediante clases y constructores con argumentos nombrados, facilitando que cada objeto reciba únicamente la información necesaria y pueda validar su estado en el momento de crearse.

Además, algunas características del lenguaje encajan directamente con decisiones tomadas en el modelo:

- Los `Symbol` permiten representar valores cerrados del dominio, como los roles `:tanque`, `:sanador` y `:dps`.
- Los `Hash` permiten indexar ramas, talentos y el progreso del personaje mediante sus identificadores, evitando búsquedas secuenciales y facilitando mantener una única correspondencia por identificador.
- Las excepciones permiten impedir la creación de estados inválidos del dominio, como rangos de talento imposibles, niveles fuera de los límites permitidos o progresos incompatibles con la clase del personaje.
- La sintaxis de Ruby permite expresar estas restricciones dentro de las propias clases del dominio sin requerir una infraestructura adicional.

Por estas razones, Ruby permite mantener el modelo del dominio compacto y hacer explícitas sus reglas e invariantes, que constituyen el objetivo principal de este milestone.

## Documentación adicional
* [Configuración establecida para el objetivo 0](./docs/configuracion.md)
* [Imagen correspondiente al juego de rol hecho en clase](./docs/rolCliente.jpg)
* [User-journeys](./docs/journeys.md)
* [Historias de Usuario](./docs/historias.md)
* [Milestones](./docs/milestones.md)

