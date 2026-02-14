# Operación Campus UIDE  
Aplicación móvil en Flutter con Geolocalización, Machine Learning y Realidad Aumentada  

---

## 🎥 Video demostrativo

 **Ver demostración (menos de 2 minutos):**  
https://youtube.com/shorts/Xk3K_ziCrlk?si=cliTxVj7CfProj1j 

El video muestra:
- Flujo completo de permisos
- Geolocalización activa en tiempo real
- Procesamiento con visión artificial
- Simulación de entorno con Realidad Aumentada

---

## 📄 Informe técnico

Consulta el archivo `INFORME_TECNICO.md` para revisar:
- Justificación de arquitectura
- Decisiones de diseño
- Estrategias de optimización de batería
- Manejo eficiente de sensores

---

## 📌 Descripción General

Operación Campus UIDE es una aplicación móvil desarrollada para el campus Loja que integra tres tecnologías clave del mercado actual:

- 📍 Geolocalización de alta precisión con GPS inteligente
- 🤖 Machine Learning para reconocimiento visual
- 🧭 Realidad Aumentada para intervención digital contextual

El diseño sigue un enfoque **Cyber-Ecology**, pensado para uso en exteriores con modo oscuro optimizado y alto contraste visual.

---

## 🚀 Funcionalidades Principales

### 1️⃣ Sistema de Gestión de Permisos
- Solicitud personalizada de permisos de cámara y ubicación
- Pantalla de error diseñada a medida (sin diálogos nativos del sistema)
- Control total del flujo antes de acceder a funcionalidades críticas

### 2️⃣ Navegación con Geolocalización Inteligente
- Integración con Google Maps en modo oscuro personalizado
- Radar dinámico de proximidad:
  - Cambia color según distancia
  - Modifica velocidad de pulso según cercanía
- Geofencing con margen de precisión de 5 metros
- Sistema de muestreo GPS adaptativo para reducir consumo energético

### 3️⃣ Reconocimiento con Machine Learning
- Captura y análisis en tiempo real usando cámara
- Umbral mínimo de confianza del 80% para validar detecciones
- Preparado para integración con modelo `.tflite` (TensorFlow Lite)

### 4️⃣ Simulación de Realidad Aumentada
- Entorno compatible conceptualmente con ARCore / ARKit
- Objeto 3D interactivo anclado en escena
- Panel informativo con datos simulados (inspirado en sistemas tipo Solmáforo)

---

## 🛠 Instalación

⚠️ Importante:  
Esta aplicación requiere un dispositivo móvil físico (Android o iOS).  
No es compatible con navegador web debido al uso de sensores nativos (GPS, cámara y AR).

### 1️⃣ Instalar dependencias
```bash
flutter pub get
