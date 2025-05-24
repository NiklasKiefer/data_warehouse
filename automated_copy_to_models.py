import os
import shutil

# Quelle: lokale SQL-Dateien
SOURCE_DIRS = {
    "staging": "stag_sql_files",
    "dimensions": "dim_sql_files",
    "facts": "fact_sql_files"
}

# Zielordner
DEST_DIRS = {
    "staging_shared": "dbt/sales_project/models/staging/shared",
    "staging_orders": "dbt/sales_project/models/staging/orders",
    "staging_inventory": "dbt/sales_project/models/staging/inventory",
    "dimensions": "dbt/sales_project/models/marts/dimensions",
    "facts": "dbt/sales_project/models/marts/facts"
}

# source.yml erwartet im shared-Bereich der Staging-Modelle
SOURCE_YML_FILE = "source.yml"
DEST_SOURCE_YML = os.path.join(DEST_DIRS["staging_shared"], SOURCE_YML_FILE)

# Zielverzeichnisse sicherstellen
for path in DEST_DIRS.values():
    os.makedirs(path, exist_ok=True)

# Staging SQL-Dateien sortiert kopieren
for filename in os.listdir(SOURCE_DIRS["staging"]):
    if not filename.endswith(".sql"):
        continue
    src_path = os.path.join(SOURCE_DIRS["staging"], filename)

    if filename == "stg_orders.sql":
        dest_path = os.path.join(DEST_DIRS["staging_orders"], filename)
    elif filename == "stg_inventory.sql":
        dest_path = os.path.join(DEST_DIRS["staging_inventory"], filename)
    else:
        dest_path = os.path.join(DEST_DIRS["staging_shared"], filename)

    shutil.copyfile(src_path, dest_path)
    print(f"✅ Kopiert: {filename} → {dest_path}")

# source.yml kopieren, falls vorhanden
if os.path.exists(SOURCE_YML_FILE):
    shutil.copyfile(SOURCE_YML_FILE, DEST_SOURCE_YML)
    print(f"✅ source.yml kopiert nach: {DEST_SOURCE_YML}")
else:
    print("⚠️  source.yml nicht gefunden – Datei muss im Projektverzeichnis liegen.")

# Dimension-Dateien kopieren
for filename in os.listdir(SOURCE_DIRS["dimensions"]):
    if filename.endswith(".sql"):
        shutil.copyfile(
            os.path.join(SOURCE_DIRS["dimensions"], filename),
            os.path.join(DEST_DIRS["dimensions"], filename)
        )
        print(f"✅ Kopiert: {filename} → {DEST_DIRS['dimensions']}")

# Fakt-Dateien kopieren
for filename in os.listdir(SOURCE_DIRS["facts"]):
    if filename.endswith(".sql"):
        shutil.copyfile(
            os.path.join(SOURCE_DIRS["facts"], filename),
            os.path.join(DEST_DIRS["facts"], filename)
        )
        print(f"✅ Kopiert: {filename} → {DEST_DIRS['facts']}")

print("\n🎉 Alle SQL-Dateien + source.yml wurden erfolgreich verschoben.")