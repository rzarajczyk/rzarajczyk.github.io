#!/bin/zsh
if [ ! $(command -v numfmt) ]; then
  echo "coreutils not installed. Please install it:\n\n    brew install coreutils\n" && exit 1
fi

VM_STAT=$(vm_stat | grep --ignore-case "pages")
PAGE_SIZE_BYTES=$(vm_stat | head -n 1 | grep -oE "[0-9]+")

function pages_to_bytes() {
    echo "$(($1 * PAGE_SIZE_BYTES))"
}

function bytes_to_human_readable() {
    echo "$1" | numfmt --to iec
}

function get_vm_stat_value_bytes() {
    pages_to_bytes "$(echo "$VM_STAT" | grep "$1" | grep -oE "[0-9]+")"
}

TOTAL_BYTES=$(sysctl hw.memsize | grep -oE "[0-9]+")

SWAP_USAGE_MB=$(sysctl vm.swapusage | grep -oE "used = [0-9,.]+." | grep -oE "[0-9]+" | head -n 1)
SWAP_USAGE_BYTES="$((SWAP_USAGE_MB * 1024))"

PAGEABLE_PAGES=$(sysctl vm.page_pageable_internal_count | grep -oE "[0-9]+")
PAGEABLE_BYTES=$(pages_to_bytes "$PAGEABLE_PAGES")

PURGEABLE_BYTES=$(get_vm_stat_value_bytes "Pages purgeable")

APP_MEMORY_BYTES=$((PAGEABLE_BYTES - PURGEABLE_BYTES))

WIRED_BYTES=$(get_vm_stat_value_bytes "Pages wired")
COMPRESSED_BYTES=$(get_vm_stat_value_bytes "Pages occupied by compressor")

USED_BYTES=$((APP_MEMORY_BYTES + WIRED_BYTES + COMPRESSED_BYTES))

FILE_BYTES=$(get_vm_stat_value_bytes "File-backed pages")

echo "Total memory: $(bytes_to_human_readable "$TOTAL_BYTES")"
echo "Used memory: $(bytes_to_human_readable "$USED_BYTES")"
echo " - App memory: $(bytes_to_human_readable "$APP_MEMORY_BYTES")"
echo " - Wired memory: $(bytes_to_human_readable "$WIRED_BYTES")"
echo " - Compressed memory: $(bytes_to_human_readable "$COMPRESSED_BYTES")"
echo "File-backed: $(bytes_to_human_readable "$FILE_BYTES")"
echo "Swap usage: $(bytes_to_human_readable "$SWAP_USAGE_BYTES")"