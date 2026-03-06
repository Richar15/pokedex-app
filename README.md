# 🎮 Pokédex - Explorador de Pokémon

Una aplicación Flutter moderna y bien diseñada para explorar información detallada sobre todos los Pokémon usando la PokéAPI.

## ✨ Características principales

- 🔍 **Búsqueda rápida** - Busca Pokémon en tiempo real
- 📋 **Listado ordenado alfabéticamente** - Todos los Pokémon organizados
- 📊 **Información detallada** - Altura, peso, tipos y más
- 🎨 **Diseño temático** - Colores clásicos de Pokémon (rojo y amarillo)
- 🖼️ **Imágenes cacheadas** - Mejor rendimiento y consumo de datos
- ⚡ **Navegación fluida** - DeepLink support con Go Router
- 🌐 **API integrada** - Conectada con PokéAPI

## 🚀 Requisitos previos

- **Flutter SDK** 3.11.1+
- **Dart** 3.11.1+
- **Android Studio** / **Xcode** (para emuladores)

## 📱 Instalación y ejecución

### 1. Clonar el repositorio
```bash
git clone <https://github.com/Richar15/pokedex-app.git>
cd pokedex
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Configurar variables de entorno
Crear archivo `.env` en la raíz del proyecto con:
```env
API_BASE_URL=https://pokeapi.co/api/v2/
```

### 4. Ejecutar la aplicación
```bash
flutter run
```

### 5. Build de producción
```bash
# Android
flutter build apk --debug

# iOS  
flutter build ios
```

## 📥 Descargas

Puedes descargar la APK compilada directamente desde las [**Releases en GitHub**](https://github.com/Richar15/pokedex-app/releases). Solo descarga e instala el APK en tu dispositivo Android.

## 🏗️ Estructura del proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── app.dart                  # Configuración de la app
├── src/
│   ├── api/                  # Cliente HTTP y constantes
│   │   ├── api_client.dart
│   │   ├── api_constants/
│   │   │   ├── api_constans.dart
│   │   │   ├── pokemon_list_state.dart
│   │   │   └── pokemon_type_colors.dart
│   │   └── interceptors.dart
│   ├── constants/            # Constantes globales
│   │   ├── app_colors.dart   # Paleta de colores Pokémon
│   │   └── app_theme.dart    # Tema de la app
│   ├── models/               # Modelos de datos
│   │   ├── pokemon.dart
│   │   └── pokemon_detail.dart
│   ├── providers/            # Gestión de estado de negocio
│   │   ├── pokemon_provider.dart
│   │   └── api_provider.dart
│   ├── router/               # Configuración de rutas
│   │   └── app_router.dart
│   ├── screens/              # Pantallas principales
│   │   ├── home_screen.dart
│   │   └── pokemon_detail_screen.dart
│   ├── services/             # Servicios API
│   │   └── pokemon_service.dart
│   └── widgets/              # Componentes reutilizables
│       ├── pokemon/
│       │   ├── pokemon_card.dart
│       │   ├── pokemon_list.dart
│       │   ├── pokemon_sprite_section.dart
│       │   ├── pokemon_info_card.dart
│       │   ├── type_chip.dart
│       │   └── stat_tile.dart
│       ├── home_app_bar.dart
│       ├── home_body.dart
│       ├── detail_body.dart
│       ├── error_view.dart
│       ├── loading_view.dart
│       ├── back_button.dart
│       └── pokemon_sprite_section.dart
```

## 🎨 Paleta de colores

| Color | Uso | Hex |
|-------|-----|-----|
| 🔴 Rojo | Primario | `#E53935` |
| 🟡 Amarillo | Secundario | `#FDD835` |
| 🔵 Azul | Terciario | `#1976D2` |

## 🛠️ Decisiones técnicas

### Navegación: **Go Router**
- Navegación declarativa y type-safe
- Soporte para deep linking
- Mejor rendimiento que Navigator 1.0

### Gestión de estados asincronos: **FutureBuilder**
- Implementación simple para operaciones de una sola vez
- Manejo claro de tres estados: cargando, error, datos

### Caché de imágenes: **cached_network_image**
- Reduce consumo de datos
- Mejora UX con carga instantánea

### APIs HTTP: **http + Interceptors**
- Cliente HTTP centralizado
- Interceptores para lógica común

### Variables de entorno: **flutter_dotenv**
- Configuración segura
- Fácil gestión entre entornos

## 📊 Flujo de datos

```
Screen -> Provider -> Service -> API Client -> PokéAPI
                         ↑
                    Caching
```

## 🎯 Plataformas soportadas

| Plataforma | Min Version |
|-----------|------------|
| Android | API 21+ |
| iOS | 11+ |

## 🔄 Funcionalidades del usuario

### Pantalla Principal
- ✅ Listado de todos los Pokémon (ordenados alfabéticamente)
- ✅ Búsqueda en tiempo real
- ✅ Carga inicial con loading spinner
- ✅ Manejo de errores (sin internet, etc.)

### Pantalla de Detalle
- ✅ Imagen del Pokémon
- ✅ Número de Pokédex
- ✅ Nombre
- ✅ Tipos (con colores temáticos)
- ✅ Altura y peso
- ✅ Botón retroceso para volver a inicio

## 📦 Dependencias principales

```yaml
flutter:
  sdk: flutter
http: ^1.6.0
go_router: ^17.1.0
cached_network_image: ^3.4.1
flutter_dotenv: ^6.0.0
flutter_launcher_icons: ^0.14.4
```

## 🚨 Solución de problemas

**Error: "No such file or directory: '.env'"**
- Crear archivo `.env` en la raíz con `API_BASE_URL`

**Las imágenes no cargan**
- Verificar conexión a internet
- Limpiar caché: `flutter clean`

**App lento al iniciar**
- Primera carga descarga todos los Pokémon (>1000)
- Cargas posteriores usan caché

## 🌐 API utilizada

- [PokéAPI](https://pokeapi.co/) - API gratuita con información de Pokémon

## 📝 Notas

- La app respeta el Material Design 3
- Tema personalizado adaptable a modo dinámico
- Código bien organizado y modular
- Sin archivos redundantes

---

**Última actualización**: Marzo 2026

