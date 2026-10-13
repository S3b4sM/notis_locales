# 🔔 Notificaciones Locales en Flutter

Esta aplicación es un proyecto demostrativo desarrollado en Flutter que implementa el paquete `flutter_local_notifications`. El objetivo principal es mostrar cómo solicitar y gestionar permisos nativos en Android, iOS y Web, así como la ejecución de notificaciones locales de forma segura.

## 🚀 Características Principales

* **Gestión de Permisos:** Solicita permisos en tiempo de ejecución (especialmente crítico en Android 13+ e iOS).
* **Manejo de Errores (Graceful Degradation):** Si el usuario deniega el permiso, la aplicación no colapsa; la interfaz se actualiza mostrando un aviso de que la función está desactivada.
* **Notificaciones Nativas:** Envía notificaciones locales con máxima prioridad (Heads-up notifications) utilizando las APIs del sistema operativo.
* **Soporte Multiplataforma:** Código unificado que maneja las restricciones específicas de Android, iOS y navegadores Web.

## ⚙️ Requisitos Previos

Para ejecutar este proyecto de forma local, necesitas:
* [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
* Editor de código (VS Code recomendado).
* Emulador de Android, dispositivo físico, o Google Chrome (para pruebas Web).

## 🛠️ Instalación y Uso

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/TU-USUARIO/notis_locales.git](https://github.com/TU-USUARIO/notis_locales.git)
   
2. **Navegar al directorio del proyecto:**
   ```bash
   cd notis_locales
3. **Obtener las dependencias:**
   ```bash
   flutter pub get  
4. **Ejecutar la aplicación:**
   ```bash
   flutter run
## ⚙️ Notas sobre Plataformas y Permisos
* **Android:** Se configuró el permiso `<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />` en el archivo `AndroidManifest.xml `(requerido a partir de API 33 / Android 13). Además, se habilitó core library desugaring en `build.gradle.kts` para garantizar la compatibilidad con las funciones modernas de Java
* **iOS:** El paquete solicita los permisos nativos de `alert`, `badge` y `sound` a través de un cuadro de diálogo al usuario, sin necesidad de configuraciones adicionales en el `Info.plist` para las funciones locales básicas
* **Web:** Se hace uso de la `API Notifications` nativa de JavaScript. Por estrictas políticas de seguridad del navegador, esta funcionalidad solo está disponible bajo contextos seguros (ejecutando en `localhost` o en sitios publicados con certificado `HTTPS`).
