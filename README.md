# Health Mini Tracker

Aplicación móvil desarrollada en Flutter como proyecto individual para la materia de Desarrollo de Aplicaciones Móviles.

Regina González Pérez
Taller de Apps/Individual 
Mayo 2026

---

## Descripción

Health Mini Tracker es una aplicación de salud personal que permite al usuario calcular su Índice de Masa Corporal (IMC), evaluar su estado físico mediante un índice de bienestar, y consultar un historial de los resultados obtenidos durante la sesión.

---

## Funcionalidades

### Calculadora de IMC
- Ingreso de peso en kilogramos y altura en metros
- Cálculo automático del Índice de Masa Corporal
- Clasificación del resultado en tres categorías: Bajo peso, Normal, Sobrepeso
- Almacenamiento del resultado en el historial de sesión

### Índice de Estado Físico
- Selección del nivel de actividad física: Baja, Media o Alta
- Ingreso del nivel de cansancio o dolor mediante un control deslizante (0 a 10)
- Cálculo de un índice de bienestar en escala de 0 a 100
- Clasificación del estado: Óptimo, Normal o Fatiga

### Historial
- Registro en memoria de todos los cálculos realizados durante la sesión
- Visualización de tipo de cálculo, valor obtenido, categoría y fecha/hora
- Opción para limpiar el historial

---

## Diseño de pantallas

El diseño de la interfaz fue prototipado en FlutterFlow antes de su implementación en Flutter.

| Calculadora IMC | Estado Físico | Historial |
|---|---|---|
| ![IMC](assets/mockups/IMC.png) | ![Estado Físico](assets/mockups/EST.FISICO.png) | ![Historial](assets/mockups/HISTORIAL.png) |

---

## Lógica de cálculo

**IMC**
IMC = peso (kg) / (altura en metros)²
Menor a 18.5          → Bajo peso
Entre 18.5 y 24.9     → Normal
Mayor o igual a 25    → Sobrepeso

**Índice de Estado Físico**
base = 100
Actividad baja   → base - 10
Actividad media  → base sin cambio
Actividad alta   → base + 10
Cansancio/dolor  → base - (nivel x 5)
Resultado final  → limitado entre 0 y 100
Mayor o igual a 75  → Óptimo
Entre 50 y 74       → Normal
Menor a 50          → Fatiga

---

## Arquitectura del proyecto

**lib/**
- main.dart — Punto de entrada y navegacion principal
- **models/** — health_record.dart — Modelo de datos del historial
- **screens/** — imc_screen.dart — Pantalla calculadora IMC
- **screens/** — estado_fisico_screen.dart — Pantalla estado fisico
- **screens/** — historial_screen.dart — Pantalla historial
- **utils/** — health_logic.dart — Logica de calculos

## Proceso de desarrollo

El desarrollo de la aplicacion siguio una metodologia estructurada por etapas,
partiendo del diseño visual hasta llegar a la implementacion funcional.

En primera instancia, se realizo el prototipado de las interfaces en FlutterFlow,
herramienta que permitio definir la distribucion visual de cada pantalla y
establecer una guia de diseno coherente con el enfoque medico de la aplicacion.

Posteriormente, se creo el proyecto en Flutter aplicando una arquitectura por capas,
separando la logica de negocio, los modelos de datos y las vistas en directorios
independientes, lo cual favorece la mantenibilidad y legibilidad del codigo.

La logica de calculo del IMC y del indice de estado fisico fue implementada en un
modulo separado, siguiendo el principio de responsabilidad unica, de modo que los
calculos puedan ser reutilizados o modificados sin afectar la interfaz de usuario.

Finalmente, se integro un sistema de historial en memoria compartido entre pantallas,
permitiendo al usuario consultar todos los resultados obtenidos durante la sesion.
La aplicacion fue probada tanto en navegador web como en dispositivo fisico Android.


---

## Instrucciones para ejecutar

**Requisitos previos**
- Flutter SDK 3.x instalado
- Visual Studio Code o Android Studio
- Emulador Android o dispositivo fisico conectado

**Pasos**

```bash
git clone https://github.com/regisgonper/Salud-tracker.git
cd Salud-tracker
flutter pub get
flutter run
```

---

## Repositorio

https://github.com/regisgonper/Salud-tracker
