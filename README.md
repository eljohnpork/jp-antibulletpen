# John Pork Antibulletpen

Dit script biedt aan om illegale kogelpenetratie in FiveM-servers te detecteren en te voorkomen. Het minimaliseert valse bans en zorgt voor eerlijk spel door verdachte activiteiten bij te houden en beheerders te waarschuwen voor handmatige controle.

## Functies
- Detecteert kogelpenetratie die verder gaat dan de ingestelde limieten.
- Houdt waarschuwingen bij voor spelers met een cooldown-systeem.
- Waarschuwt beheerders voor potentiële cheaters voor handmatige verificatie.
- Optionele kickfunctie na meerdere waarschuwingen.
- Logt verdachte activiteiten voor externe beoordeling.

## Installatie
1. Download het script en plaats het in de **resources**-map van je FiveM-server.
2. Voeg de resource toe aan je `server.cfg`:
   ```cfg
   ensure jp-antibulletpen
   ```
3. Start de server opnieuw.

## Configuratie
Het script bevat verschillende configuratie-opties die kunnen worden aangepast in het **`anti_penetration.lua`**-bestand:

- `MAX_ALLOWED_PENETRATION`: Maximale penetratielimiet in meters.
- `WARNING_THRESHOLD`: Aantal waarschuwingen voordat een speler wordt gekicked.
- `COOLDOWN_TIME`: Tijd in seconden voordat waarschuwingen worden gereset.
- `KICK_MESSAGE`: Bericht dat wordt weergegeven wanneer een speler wordt gekicked.

## Gebruiksaanwijzing
- **Automatische detectie**: Het script detecteert automatisch verdachte kogelpenetratie en registreert waarschuwingen.
- **Adminmelding**: Beheerders ontvangen een melding wanneer een speler verdacht gedrag vertoont.
- **Debugfunctie**: Beheerders kunnen de status van het script controleren met het commando `/checkPenetration`.

## Toekomstige uitbreidingen
- Integratie met een externe database voor uitgebreidere logging.
- Configuratie via een webpaneel.

## Disclaimer
Dit script is ontworpen om vals spelen tegen te gaan, maar het is belangrijk om verdachte gevallen altijd handmatig te controleren om onterechte bans te voorkomen.

## Licentie
Dit script is vrij te gebruiken en aan te passen. Geef credit aan de oorspronkelijke auteur als je het deelt.

---
**Auteur**: eljohnpork  
**Versie**: 1.0.0

