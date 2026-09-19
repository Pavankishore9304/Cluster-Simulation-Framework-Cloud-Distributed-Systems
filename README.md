# Cluster Simulation Framework

A Python-based distributed computing cluster simulator with real-time monitoring, pod scheduling, and chaos testing capabilities.

## Features

- **Node Management**
  - Add/remove nodes with customizable CPU and memory
  - Health monitoring via heartbeats
  - Support for different node types (balanced, high_cpu, high_mem)
  - Network group isolation

- **Pod Scheduling**
  - Multiple scheduling algorithms (first_fit, best_fit, worst_fit)
  - Resource requirement specifications
  - Node affinity support
  - Network group isolation

- **Auto-Scaling**
  - Automatic node addition when CPU utilization > 80%
  - Configurable scaling thresholds and cooldown periods

- **Real-Time Dashboard**
  - Interactive web interface built with React and Material-UI
  - Live cluster state visualization
  - Resource utilization graphs
  - 3D node network visualization
  - Dark mode support

- **Chaos Testing**
  - Built-in Chaos Monkey for random node failures
  - Automatic pod rescheduling from failed nodes

- **Persistence**
  - MySQL database integration for state persistence
  - Event logging
  - Utilization history tracking

## Requirements

- **Python 3.8+**
- **MySQL Database Server** (running locally or remotely)
- *Docker* (completely optional — only needed if you want containerized nodes)
- *Node.js* (not required — dashboard uses lightweight client-side CDN assets)

## Quick Start (Effortless 1-Step Setup)

The quickest way to start the project after cloning is using the automated launcher scripts. They will automatically create a Python virtual environment, install all dependencies, verify the database, start the server, add sample nodes, and open your dashboard:

### On Windows:
```cmd
quick_start.bat
```

### On Linux / macOS:
```bash
chmod +x quick_start.sh
./quick_start.sh
```

---

## Manual Setup (Step-by-Step)

If you prefer to set up manually:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/cluster-simulation-framework.git
   cd cluster-simulation-framework
   ```

2. **Create & Activate a Virtual Environment:**
   - **Windows (PowerShell):**
     ```powershell
     python -m venv venv
     .\venv\Scripts\Activate.ps1
     ```
   - **Linux / macOS:**
     ```bash
     python3 -m venv venv
     source venv/bin/activate
     ```

3. **Install Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure Database:**
   - Copy `.env.example` to `.env`:
     ```bash
     cp .env.example .env
     ```
   - Edit `.env` to match your local MySQL credentials:
     ```env
     MYSQL_HOST=localhost
     MYSQL_USER=root
     MYSQL_PASSWORD=your_password
     MYSQL_DATABASE=cluster_sim
     ```
   *(Note: The `cluster_sim` database and its tables will automatically be created on first connection if they do not already exist).*

5. **Verify Database Connection:**
   ```bash
   python test_mysql.py
   ```

6. **Start the Simulator Server:**
   ```bash
   python server_new.py
   ```

7. **Access the Web Dashboard:**
   Open your browser and navigate to: **[http://localhost:5000](http://localhost:5000)**

## CLI Usage

```bash
# Add a node
python client.py add_node --cpu 8 --memory 16 --node_type balanced --network_group default

# Launch a pod
python client.py launch_pod --cpu_required 2 --memory_required 4 --scheduling_algorithm first_fit

# List all nodes
python client.py list_nodes

# Trigger chaos monkey
python client.py chaos_monkey

# Open dashboard
python client.py dashboard
```

## Docker Support

```bash
# Build node simulator image
docker build -t node-simulator .

# Run a node simulator
docker run -e NODE_ID=node1 -e SERVER_URL=http://host.docker.internal:5000 node-simulator
```

## Project Structure

```
├── server_new.py         # Main server implementation
├── client.py            # CLI client
├── node.py             # Node simulator
├── supabase_init.py    # Supabase integration
├── static/             # Dashboard frontend
│   ├── index.html
│   ├── app.js
│   └── styles.css
├── requirements.txt    # Python dependencies
└── Dockerfile         # Node simulator container
```

## API Endpoints

- `POST /api/add_node` - Add a new node
- `POST /api/launch_pod` - Launch a new pod
- `GET /api/list_nodes` - List all nodes
- `POST /api/chaos_monkey` - Trigger chaos monkey
- `GET /api/utilization_history` - Get utilization history

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with Flask, React, and Material-UI
- Uses Supabase for persistence
- Inspired by container orchestration systems like Kubernetes

