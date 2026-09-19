#!/bin/bash
set -e

echo "==================================================="
echo "    Cluster Simulation Framework - Quick Start"
echo "==================================================="
echo ""

# 1. Setup Virtual Environment
if [ ! -d "venv" ]; then
    echo "[*] Creating virtual environment (venv)..."
    python3 -m venv venv || python -m venv venv
fi

echo "[*] Activating virtual environment..."
source venv/bin/activate

# 2. Setup .env file
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    echo "[*] Creating .env from .env.example..."
    cp .env.example .env
fi

# 3. Install/Verify Dependencies
echo "[*] Installing / verifying dependencies..."
pip install -r requirements.txt --quiet

# 4. Test MySQL Connection
echo "[*] Checking MySQL connection..."
python test_mysql.py

# 5. Launch Server in Background
echo "[*] Starting the cluster simulation server..."
python server_new.py &
SERVER_PID=$!

echo "[*] Waiting for server initialization..."
sleep 4

# 6. Seed Initial Test Node & Pod
echo "[*] Adding initial test node (8 CPU, 16GB RAM)..."
python client.py add_node --cpu 8 --memory 16 --node_type balanced

echo "[*] Launching initial test pod (2 CPU, 4GB RAM)..."
python client.py launch_pod --cpu_required 2 --memory_required 4 --scheduling_algorithm first_fit

# 7. Open Dashboard
echo ""
echo "==================================================="
echo "[SUCCESS] Cluster Simulation Framework is running!"
echo "Dashboard: http://localhost:5000"
echo "==================================================="
python client.py dashboard || true
echo ""
echo "Press Ctrl+C to stop the server when finished."

wait $SERVER_PID