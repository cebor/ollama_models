# ollama-modelfiles

Ollama Modelfile collection for local AI coding workflows, optimized for two machines.

## Hardware

| Machine | Chip | RAM | VRAM |
|---------|------|-----|------|
| MacBook | Apple M3 | 24 GB Unified Memory | — |
| PC | NVIDIA RTX 5090 | 64 GB RAM | 32 GB VRAM |

## Models

| Model | Type | Size (Q4_K_M) | Mac ctx | PC ctx |
|-------|------|---------------|---------|--------|
| gemma4:26b-a4b-it-q4_K_M | MoE | ~18 GB | 16384 | 131072 |
| gemma4:31b-it-q4_K_M | Dense | ~21 GB | 8192 | 32768 |
| qwen3.6:27b-q4_K_M | Dense | ~17 GB | 8192 | 32768 |
| qwen3.6:35b-a3b-q4_K_M | MoE | ~24 GB | — | 131072|


## Setup

### Mac Setup
```bash
# Create custom configs
ollama create gemma4-26b-coding -f ./mac-m3-24gb/gemma4-26b-a4b-it-q4_K_M.txt
ollama create gemma4-31b-planning -f ./mac-m3-24gb/gemma4-31b-it-q4_K_M.txt
ollama create qwen3.6-27b-planning -f ./mac-m3-24gb/qwen3.6-27b-q4_K_M.txt
ollama list
```

### PC Setup
```bash
# Create custom configs
ollama create gemma4-26b-coding -f ./pc-rtx5090-32gb/gemma4-26b-a4b-it-q4_K_M.txt
ollama create gemma4-31b-planning -f ./pc-rtx5090-32gb/gemma4-31b-it-q4_K_M.txt
ollama create qwen3.6-27b-planning -f ./pc-rtx5090-32gb/qwen3.6-27b-q4_K_M.txt
ollama create qwen3.6-35b-coding -f ./pc-rtx5090-32gb/qwen3.6-35b-a3b-q4_K_M.txt
ollama list
```

## Repository Structure
```
ollama-modelfiles/
├── README.md
├── mac-m3-24gb/
│   ├── gemma4-26b-a4b-it-q4_K_M.txt
│   ├── gemma4-31b-it-q4_K_M.txt
│   └── qwen3.6-27b-q4_K_M.txt
├── pc-rtx5090-32gb/
│   ├── gemma4-26b-a4b-it-q4_K_M.txt
│   ├── gemma4-31b-it-q4_K_M.txt
│   ├── qwen3.6-27b-q4_K_M.txt
│   └── qwen3.6-35b-a3b-q4_K_M.txt
└── scripts/
    └── ollama-network-expose.ps1
```

## Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `num_ctx` | varies by model/hardware | Maximum context length in tokens |
| `num_predict` | 2048 / 4096 / 8192 | Maximum response length |
| `temperature` | 0.2 (coding) / 0.5 (planning) | Coding = deterministic output; Planning = more creative reasoning |
| `repeat_penalty` | 1.1 | Prevents repetitive outputs |

## VS Code Copilot Chat

After setup, select the desired model in Copilot Chat:
- `gemma4-26b-coding`
- `gemma4-31b-planning`
- `qwen3.6-35b-coding` *(PC only)*
- `qwen3.6-27b-planning`

## Scripts

| Script | Platform | Description |
|--------|----------|-------------|
| `scripts/ollama-network-expose.ps1` | Windows (PowerShell) | Exposes the Ollama API on the local network |

```powershell
# Run from repo root in an elevated PowerShell session
powershell -ExecutionPolicy Bypass -File .\scripts\ollama-network-expose.ps1
```