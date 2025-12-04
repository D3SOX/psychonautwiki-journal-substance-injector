#!/bin/bash

# FTP Deployment Script
#
# Password retrieval priority:
#   1. .env file (FTP_PASSWORD=...)
#   2. Environment variable (FTP_PASSWORD=...)
#   3. Interactive prompt
#
# Usage:
#   ./deploy.sh

set -e  # Exit on error

FTP_HOST="d3sox.lima-ftp.de"
FTP_USER="d3sox"
FTP_REMOTE_DIR="/d3sox.lima-city.de/journal-substance-injector/"

# Load .env file if it exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/.env" ]; then
    set -a
    # shellcheck disable=SC1091
    source "$SCRIPT_DIR/.env"
    set +a
fi

FTP_PASSWORD="${FTP_PASSWORD:-}"  # Use from .env, environment variable, or prompt

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting FTP deployment...${NC}"

# Check if lftp is installed
if ! command -v lftp &> /dev/null; then
    echo -e "${RED}Error: lftp is not installed.${NC}"
    echo "Install it with: sudo pacman -S lftp (Arch) or sudo apt-get install lftp (Debian/Ubuntu)"
    exit 1
fi

# Files to deploy
FILES=("index.html" "sw.js")

# Check if files exist
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: File $file not found!${NC}"
        exit 1
    fi
done

# Expand array to space-separated string for lftp
FILES_STR="${FILES[*]}"

# Prompt for password if not set
if [ -z "$FTP_PASSWORD" ]; then
    echo -e "${YELLOW}Enter FTP password (will not be displayed):${NC}"
    read -rs FTP_PASSWORD
    echo ""  # New line after password input
fi

# Deploy using lftp
if lftp -c "
set ftp:ssl-allow no
open -u $FTP_USER,$FTP_PASSWORD $FTP_HOST
cd $FTP_REMOTE_DIR
lcd $(pwd)
mput $FILES_STR
bye
"; then
    echo -e "${GREEN}✓ Deployment successful!${NC}"
else
    echo -e "${RED}✗ Deployment failed!${NC}"
    exit 1
fi

