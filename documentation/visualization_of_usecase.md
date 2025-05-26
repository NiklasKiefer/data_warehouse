## Use Case: Jahresabschlussanalyse für das Geschäftsjahr 2024

Zum Jahresende möchte das Management deines IT-Vertriebsunternehmens eine umfassende Analyse des Umsatzes vom vergangenen Geschäftsjahr 2024 durchführen.  
Ziel ist es, auf Basis dieser Auswertung fundierte Erkenntnisse für die strategische Planung  des Geschäftsjahres 2025 zu gewinnen.  

Erstelle einen interaktiven Power BI-Bericht und analysiere, welche Produkte, Kundenregionen und Geschäftsstandorte im Jahr 2024 den größten Einfluss auf den Umsatz hatten. Untersuche außerdem, wie sich diese Umsatztreiber im zeitlichen Verlauf entwickelt haben.  

Nutze interaktive Visualisierungen, um folgende Fragestellungen datenbasiert zu analysieren:  
• Wie hoch ist der Gesamtjahresumsatz 2024?  
• Wie hat sich der Umsatz im Laufe des Jahres 2024 entwickelt?  
• Welche Produkte und Bundesstaaten waren besonders umsatzstark?  
• Welche Geschäftsstandorte haben den größten Anteil am Gesamtumsatz erzielt?

---

## Anleitung: Erstellung eines Power BI-Berichts für die Jahresabschlussanalyse 2024

### 1. Voraussetzungen

* Installiere **Power BI Desktop**
* Starte deinen **Docker-Container** mit der Datenbank

### 2. Datenverbindung herstellen

1. Öffne **Power BI Desktop**
2. Wähle **Abrufen aus anderer Quelle**
3. Gehe zu **Datenbank → PostgreSQL-Datenbank → Verbinden**
4. Gib folgende Verbindungsdaten ein:
   * **Server**: `localhost:5432`
   * **Datenbank**: `sales_dw`
   * **Benutzername**: `dbt`
   * **Passwort**: `dbt`
5. Wähle im **Navigator** folgende Tabellen aus:
   * Alle `public.dim...`-Tabellen
   * Die beiden `public.fact...`-Tabellen
6. Klicke auf **Laden**

### 3. Erste Schritte in Power BI

* **Tabellenansicht** (links, 2. Symbol): Überblick über Aufbau und Inhalt der Tabellen
* **Modellansicht** (links, 3. Symbol): Darstellung der Beziehungen zwischen den Tabellen
* **Berichtsansicht** (links, 1. Symbol): Hier erstellen wir unsere Visualisierungen

### 4. Datenmodell ergänzen

- Wir erstellen das Measure `Umsatz` in der Tabelle `public fact_orders`:  
  ``Umsatz = SUMX('public fact_orders', 'public fact_orders'[quantity] * 'public fact_orders'[unit_price])``
  Dabei klicken wir unter Tabellenansicht auf die genannte Tabelle und wählen oben unter Berechnungen Neues Measure aus.
- Danach können wir mit den Visualisierungen starten.

### 5. Visualisierungen erstellen

#### 1. Auswahl Geschäftsmonat
- **Visualisierung:** Datenschnitt
- **Feld:** `dim_datetime[year_month]`

#### 2. Auswahl Produkttyp
- **Visualisierung:** Datenschnitt
- **Feld:** `dim_products[product_type]`

#### 3. Umsatzentwicklung im Geschäftsjahr 2024
- **Visualisierung:** Liniendiagramm
- **X-Achse:** `dim_datetime[month]`
- **Y-Achse:** Umsatz

#### 4. Umsatzstärksten Produkte
- **Visualisierung:** KPI
- **Wert:** Umsatz
- **Trendachse:** `dim_datetime[year]`

#### 5. Jahresumsatz 2024
- **Visualisierung:** Gestapeltes Balkendiagramm
- **Y-Achse:** `dim_products.product_name`
- **X-Achse:** Umsatz

#### 6. Umsatzstärkste Kundenregionen
- **Visualisierung:** Gestapeltes Säulendiagramm
- **X-Achse:** `dim_customers[state]`
- **Y-Achse:** Umsatz

#### 7. Umsatz im Jahr 2024 pro Geschäftsstandort
- **Visualisierung:** Ringdiagramm
- **Legende:** `dim_location[location_name]`
- **Werte:** Umsatz

