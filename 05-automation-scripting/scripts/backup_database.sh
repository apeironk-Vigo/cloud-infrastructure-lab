#!/usr/bin/env bash
set -e

BACKUP_DIR="${HOME}/postgres_backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/vigo_lab_db_${TIMESTAMP}.sql.gz"

mkdir -p "${BACKUP_DIR}"

echo "🔄 Fetching PostgreSQL pod name..."
POD_NAME=$(kubectl get pods -n database -l app=postgres -o jsonpath='{.items[0].metadata.name}')

if [ -z "${POD_NAME}" ]; then
  echo "❌ Error: Could not find running PostgreSQL pod."
  exit 1
fi

echo "📦 Dumping 'vigo_lab_db' from pod [${POD_NAME}]..."
kubectl exec -n database "${POD_NAME}" -- pg_dump -U vigo_user -d vigo_lab_db | gzip > "${BACKUP_FILE}"

echo "✅ Backup successfully created at: ${BACKUP_FILE}"
ls -lh "${BACKUP_FILE}"