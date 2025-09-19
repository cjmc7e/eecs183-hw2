#!/bin/bash

# This script downloads and unzips the FastText Common Crawl models for
# English, French, and Japanese.
# WARNING: These files are very large (5-7 GB each). The process will
# require significant disk space (~20 GB) and time.

echo "--- Starting FastText Model Download ---"

# Array of language codes to download
LANGS=("en" "fr")

# Base URL for the models
BASE_URL="https://dl.fbaipublicfiles.com/fasttext/vectors-crawl"

for lang in "${LANGS[@]}"; do
  GZ_FILE="cc.${lang}.300.bin.gz"
  BIN_FILE="cc.${lang}.300.bin"
  URL="${BASE_URL}/${GZ_FILE}"

  # --- Download the file if it doesn't exist ---
  if [ ! -f "$GZ_FILE" ] && [ ! -f "$BIN_FILE" ]; then
    echo "Downloading ${lang} model from ${URL}..."
    wget -c "$URL"
  else
    echo "Archive for ${lang} model already exists. Skipping download."
  fi
  
  # --- Unzip the file if the binary doesn't exist ---
  if [ -f "$GZ_FILE" ] && [ ! -f "$BIN_FILE" ]; then
    echo "Unzipping ${GZ_FILE}..."
    gunzip "$GZ_FILE"
    echo "${BIN_FILE} created."
  elif [ -f "$BIN_FILE" ]; then
    echo "${BIN_FILE} already exists. Skipping unzip."
  else
    echo "Could not find archive ${GZ_FILE} to unzip."
  fi
  
  echo "--- Finished processing for ${lang} ---"
  echo ""
done

echo "All models processed."
