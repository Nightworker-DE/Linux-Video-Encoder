#!/bin/bash

# =======================================================================
# Titel: install.sh
# Version: 1.0
# Autor: Nightworker
# Datum: 2025-11-16
# Beschreibung: richtet ein virtuelles Python mit tkinterdnd2 ein,
# Der Username im Shebang wird automatisch angepasst
# Lizenz: MIT
# ===================================================================

# aktueller Benutzer
USER_NAME=$(whoami)

# Datei, die geändert werden soll
FILE="Linux-Video-Encoder.py"

# neues Shebang
NEW_SHEBANG="#!/home/$USER_NAME/venv/bin/python3"

# Prüfen, ob die Datei existiert
if [ ! -f "$FILE" ]; then
    echo "Datei $FILE existiert nicht."
    exit 1
fi

# Shebang ersetzen oder hinzufügen
# Wenn die erste Zeile ein Shebang ist, ersetze sie, sonst füge sie ein
if head -n 1 "$FILE" | grep -q "^#!"; then
    # erste Zeile ersetzen
    sed -i "1s|.*|$NEW_SHEBANG|" "$FILE"
else
    # Shebang oben einfügen
    sed -i "1i $NEW_SHEBANG" "$FILE"
fi

echo "Shebang in '$FILE' wurde auf '$NEW_SHEBANG' gesetzt."

# Skript zum Einrichten einer Python-Umgebung mit tkinterdnd2

# Automatisch das Home-Verzeichnis des aktuellen Benutzers nutzen
USER_HOME="$HOME"
VENV_PATH="$USER_HOME/venv"

# Systempakete installieren
echo "Installiere benötigte Systempakete..."
sudo apt update
sudo apt install -y python3-venv python3-tk python3-pip

# Virtuelle Umgebung erstellen
echo "Erstelle virtuelle Umgebung in $VENV_PATH..."
python3 -m venv "$VENV_PATH"

# Virtuelle Umgebung aktivieren
echo "Aktiviere virtuelle Umgebung..."
source "$VENV_PATH/bin/activate"

# tkinterdnd2 installieren
echo "Installiere tkinterdnd2..."
python3 -m pip install --upgrade pip
python3 -m pip install tkinterdnd2

# Virtuelle Umgebung deaktivieren
deactivate
sudo apt remove -y python3-venv python3-pip
echo "Fertig! Virtuelle Umgebung wurde in $VENV_PATH eingerichtet."

