#!/usr/bin/env python3
import json
import subprocess
import sys

def run_command(cmd):
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, check=True)
        return json.loads(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")
        sys.exit(1)

def check_nodes():
    print("--- 🖥️ Node Health Check ---")
    data = run_command("kubectl get nodes -o json")
    for item in data.get("items", []):
        name = item["metadata"]["name"]
        conditions = item["status"]["conditions"]
        ready_status = next((c["status"] for c in conditions if c["type"] == "Ready"), "Unknown")
        print(f"Node: {name} | Ready: {ready_status}")

def check_pods():
    print("\n--- 📦 Pod Restart & Status Check ---")
    data = run_command("kubectl get pods -A -o json")
    unhealthy_count = 0
    
    for item in data.get("items", []):
        namespace = item["metadata"]["namespace"]
        name = item["metadata"]["name"]
        status = item["status"].get("phase", "Unknown")
        
        container_statuses = item["status"].get("containerStatuses", [])
        restarts = sum(cs.get("restartCount", 0) for cs in container_statuses)
        
        if status != "Running" or restarts > 5:
            print(f"⚠️  [ATTENTION] Namespace: {namespace} | Pod: {name} | Status: {status} | Restarts: {restarts}")
            unhealthy_count += 1

    if unhealthy_count == 0:
        print("✅ All cluster pods are healthy with normal restart counts.")

if __name__ == "__main__":
    print("🚀 Starting K3s Cluster Health Audit...\n")
    check_nodes()
    check_pods()
    print("\nAudit Complete.")