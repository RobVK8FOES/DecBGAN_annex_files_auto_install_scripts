#!/bin/bash

# Define the repository root
REPO_ROOT="$HOME/DecBGAN"

echo "[INFO] Initializing repository environment at ${REPO_ROOT}..."
mkdir -p "${REPO_ROOT}"
cd "${REPO_ROOT}" || { echo "[ERROR] Failed to access directory."; exit 1; }

# Main attachments bundle for TS 102 744-2-1 and the Bearer-Control PDF
URL_ANNEX_BUNDLE="https://www.etsi.org/deliver/etsi_ts/102700_102799/1027440201/01.01.01_60/ts_1027440201v010101p0.zip"
URL_PDF="https://www.etsi.org/deliver/etsi_ts/102700_102799/1027440301/01.01.01_60/ts_1027440301v010101p.pdf"

# User-Agent string to bypass anti-scraping blocks
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"

echo "[INFO] Downloading Annex bundle..."
wget -nc --show-progress -U "$USER_AGENT" "$URL_ANNEX_BUNDLE"

echo "[INFO] Downloading Bearer-Control PDF..."
wget -nc --show-progress -U "$USER_AGENT" "$URL_PDF"

echo "[INFO] Extracting archives..."

# Verify the master bundle downloaded successfully
if [ -f "ts_1027440201v010101p0.zip" ]; then
    # Extract the master bundle, which contains the individual Annex zips
    unzip -n ts_1027440201v010101p0.zip
    
    # Verify the nested Annex zips were extracted, then unpack them
    # The -d flag is omitted because the zips already contain the correct root folders
    if [ -f "ts_1027440201_AnnexC1_v010101p0.zip" ] && [ -f "ts_1027440201_AnnexC2_v010101p0.zip" ]; then
        unzip -n ts_1027440201_AnnexC1_v010101p0.zip
        unzip -n ts_1027440201_AnnexC2_v010101p0.zip
        echo "[INFO] Setup completed successfully."
    else
        echo "[ERROR] Master bundle downloaded, but Annex C1/C2 zips were not found inside."
        exit 1
    fi
else
    echo "[ERROR] Required master bundle download failed."
    exit 1
fi
