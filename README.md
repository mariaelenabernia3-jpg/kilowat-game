# KILOWAT - Guía de Colaboración en Equipo

## 📌 Reglas de Oro para evitar conflictos en Git:
1. **Nunca trabajen sobre la misma escena (`.tscn`) al mismo tiempo:**
   - Si Developer A está modificando la habitación (`features/room/`), Developer B debe trabajar en un minijuego (`features/minigames/`) o en la tienda (`features/economy/`).
2. **Usa ramas (Branches):**
   - No programes directo en `main`. Crea ramas: `git checkout -b feature/nuevo-minijuego`.
3. **Todo cambio global se hace en `core/`:**
   - Si necesitas una nueva señal, agrégala en `core/state/event_bus.gd`.
