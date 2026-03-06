# Pokédex

Una aplicación de Flutter para explorar información sobre Pokémon usando la PokéAPI.

## Requisitos previos

- Flutter SDK 3.11.1+
- Dart 3.11.1+
- Android Studio / Xcode (para emuladores)

## Instalación y ejecución

1. **Clonar el repositorio**
   ```bash
   git clone <https://github.com/Richar15/pokedex-app.git>
   cd pokedex
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**
   - Crear archivo `.env` en la raíz del proyecto
   - Añadir las variables necesarias (p.ej. API base URL)

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

5. **Build de producción**
   ```bash
   # Android
   flutter build apk

   # iOS
   flutter build ios
   ```

## Decisiones técnicas

### Navegación: Go Router
- Navegación declarativa y type-safe
- Soporte para deep linking
- Mejor rendimiento que Navigator 1.0

### Gestión de estados asincronos: FutureBuilder
- Implementación simple y directa para operaciones de una sola vez
- Manejo claro de tres estados: cargando, error, datos

### Caché de imágenes: cached_network_image
- Reduce consumo de datos
- Mejora UX con carga instantánea de imágenes vistas

### APIs HTTP: http + Interceptors
- Cliente HTTP centralizado en `lib/src/api/`
- Interceptores para centralizar lógica común (headers, errores)

### Variables de entorno: flutter_dotenv
- Configuración segura sin hardcodear URLs o keys
- Fácil gestión entre entornos (dev, prod)

### Estructura del proyecto
```
lib/src/
  ├── api/           # Cliente HTTP y constantes
  ├── models/        # Modelos de datos
  ├── providers/     # Proveedores de negocio
  ├── router/        # Configuración de rutas
  ├── screens/       # Pantallas del app
  ├── services/      # Servicios auxiliares
  └── widgets/       # Componentes reutilizables
```

## Plataformas soportadas

- Android (min API 21)
- iOS (min iOS 11)

