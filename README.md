# aygp_frontend

Aplicación móvil para el proyecto Ayuda y Gestión Psicológica.

## Futuras mejoras.
  - Cuando se guarde un suceso clave, se guardará la ubicación, y luego en la ficha de edición, se mostrará dicha ubicación en un mapa (Apple Mapas o Google Maps).

## A documentar...
  - Providers.
    - Providers globales tienen característica LAZY. Hasta que no se necesitan, no se instancian.
  - AuthProvider.
  - SecureStorage (login, logout)
  - CheckAuthScreen (FutureBuilder con Microtasks).
  - DiaryService.
    - El método que trae la información desde el servidor lo he tenido que hacer más manual porque json.decode no lo hacía dinámicamente.
    - Al actualizar, no se vuelve a solicitar una petición al servidor sino que solo se hace una vez en todo el lanzamiento de la aplicación, es decir, se lanza la petición de actualización al servidor y posteriormente se modifica LOCALMENTE.
  - DiaryScreen.
    - En el evento onLongPress de cada item, compruebo si la plataforma es IOS o ANDROID para mostrar un AlertDialog.