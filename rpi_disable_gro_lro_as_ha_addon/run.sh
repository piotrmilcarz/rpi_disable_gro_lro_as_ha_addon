#!/bin/sh

echo "[disable-gro-lro] Starting..."

sleep 10

IFACE=$(jq -r '.interface' /data/options.json)

if [ -z "$IFACE" ] || [ "$IFACE" = "null" ]; then
  IFACE=$(ip route | grep default | awk '{print $5}' | head -n1)
  echo "[disable-gro-lro] Auto-detected interface: $IFACE"
else
  echo "[disable-gro-lro] Using configured interface: $IFACE"
fi

if [ -n "$IFACE" ]; then
  echo "[disable-gro-lro] Disabling GRO/LRO on $IFACE"

  ethtool -K $IFACE gro off 2>/dev/null || echo "GRO not supported"
  ethtool -K $IFACE lro off 2>/dev/null || echo "LRO not supported"

  echo "[disable-gro-lro] Done"
else
  echo "[disable-gro-lro] No interface detected!"
fi

# keep container alive
tail -f /dev/null