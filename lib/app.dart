import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notis_locales/main.dart';

class MiAppNotificaciones extends StatelessWidget {
  const MiAppNotificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notificaciones Locales',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  bool _permisoConcedido = false;

  // Función para solicitar permisos
  Future<void> _solicitarPermisos() async {
    bool concedido = false;

    if (kIsWeb) {
      // Para Web 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Web requiere Notification API de JS')),
      );
      return;
    }

    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted =
          await androidImplementation?.requestNotificationsPermission();
      concedido = granted ?? false;
    } else if (Platform.isIOS) {
      final bool? granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      concedido = granted ?? false;
    }

    setState(() {
      _permisoConcedido = concedido;
    });

    // Manejo del permiso negado
    if (!concedido) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permiso denegado. Función deshabilitada.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
       if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permiso concedido exitosamente.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  // Función para mostrar la notificación
  Future<void> _mostrarNotificacion() async {
    if (!_permisoConcedido && !kIsWeb) {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debes aceptar el permiso primero')),
        );
      return;
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'canal_id_1',
      'Canal de Notificaciones',
      channelDescription: 'Descripción del canal',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // ID de la notificación
      '¡Hola Jilmer!', // Título
      'Esta es una notificación local de prueba', // Cuerpo
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones Locales')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _permisoConcedido ? Icons.notifications_active : Icons.notifications_off,
              size: 80,
              color: _permisoConcedido ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _solicitarPermisos,
              icon: const Icon(Icons.security),
              label: const Text('1. Solicitar Permisos'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _mostrarNotificacion,
              icon: const Icon(Icons.send),
              label: const Text('2. Mostrar Notificación'),
            ),
          ],
        ),
      ),
    );
  }
}