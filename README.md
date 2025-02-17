# 🚀 API Rack con Autenticación y Creación Asíncrona de Productos

Este proyecto es una API basada en Rack que implementa autenticación mediante Bearer Token, creación asíncrona de productos y documentación OpenAPI.

## 📌 ¿Cómo iniciar la aplicación?

1. **Instalar Docker** (si aún no lo tienes instalado).
2. **Iniciar Docker Desktop** (si estás en Windows).
3. **Ejecutar el siguiente comando** en Linux o WSL de Windows:
   ```sh
   docker-compose up --build
   ```
4. **¡Listo!** Ahora puedes probar los endpoints utilizando la colección de Postman incluida en el proyecto.

---

## 📌 Consideraciones

- **Autenticación**: Se ha habilitado solo una cuenta de usuario:
  - **Usuario**: `admin`
  - **Contraseña**: `password123`
  
- **Base de datos**: Se utiliza una base de datos para acercar la aplicación a un caso real.

- **Creación asíncrona de productos**: Se ha implementado con *Sidekiq*, una herramienta comúnmente utilizada para procesar trabajos en segundo plano.

- **Simulación del procesamiento de creación de productos**: Se utiliza `sleep()`, aunque también podría usarse `perform_in` para programar la ejecución con retraso.

- **Documentación OpenAPI**: Disponible en la ruta `/openapi`.

---

## 📌 Endpoints

### 🔑 Autenticación
- **POST** `http://localhost:9292/auth`
  - **Body de ejemplo**:
    ```json
    {"user": "admin", "password": "password123"}
    ```
  - **Respuesta**:
    ```json
    { "token": "tokengenerado" }
    ```

### 🛒 Crear producto (asíncrono)
- **POST** `http://localhost:9292/products`
  - **Headers requeridos**:
    ```
    Authorization: Bearer tokengenerado
    Content-Type: application/json
    ```
  - **Body de ejemplo**:
    ```json
    {"name": "Pizza cuatro quesos"}
    ```
  - **Respuesta**:
    ```json
    { "message": "Product creation in progress" }
    ```
  - **Ejemplo con `curl`**:
    ```sh
    curl -X POST http://localhost:9292/products \
         -H "Content-Type: application/json" \
         -H "Authorization: Bearer tokengenerado" \
         -d '{"name": "Pizza cuatro quesos"}'
    ```

### 📋 Listar productos
- **GET** `http://localhost:9292/products`
  - **Respuesta de ejemplo**:
    ```json
    [
      {
        "id": 1,
        "name": "Pizza cuatro quesos"
      }
    ]
    ```

### 📄 Información de autores
- **GET** `http://localhost:9292/authors`
  - **Respuesta**:
    ```
    Franco Martin Raniolo
    ```

### 📜 Documentación OpenAPI
- **GET** `http://localhost:9292/openapi`
  - **Respuesta**: Esquema de OpenAPI en formato JSON.

---

## 📌 Notas adicionales

- **Sidekiq** debe estar corriendo para procesar las tareas en segundo plano.
- Para pruebas más cómodas, se recomienda importar la colección de Postman adjunta.



  
