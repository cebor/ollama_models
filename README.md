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
| gemma4:26b | MoE | ~18 GB | 16384 | 65536 |
| gemma4:31b | Dense | ~21 GB | 8192 | 32768 |
| qwen3.5:35b | MoE | ~24 GB | - | 65536 |
| qwen3.5:27b | Dense | ~17 GB | 8192 | 32768 |


## Setup

### Mac Setup
```bash
# Pull models
ollama pull gemma4:26b
ollama pull gemma4:31b
ollama pull qwen3.5:27b

# Create custom configs
ollama create gemma4-26b-coding -f ./mac-m3-24gb/gemma4-26b-moe.txt
ollama create gemma4-31b-coding -f ./mac-m3-24gb/gemma4-31b-dense.txt
ollama create qwen3.5-27b-coding -f ./mac-m3-24gb/qwen3.5-27b-dense.txt
ollama list
```

### PC Setup
```bash
# Pull models
ollama pull gemma4:26b
ollama pull gemma4:31b
ollama pull qwen3.5:27b
ollama pull qwen3.5:35b

# Create custom configs
ollama create gemma4-26b-coding -f ./pc-rtx5090-32gb/gemma4-26b-moe.txt
ollama create gemma4-31b-coding -f ./pc-rtx5090-32gb/gemma4-31b-dense.txt
ollama create qwen3.5-27b-coding -f ./pc-rtx5090-32gb/qwen3.5-27b-dense.txt
ollama create qwen3.5-35b-coding -f ./pc-rtx5090-32gb/qwen3.5-35b-moe.txt
ollama list
```

## Repository Structure
```
ollama-modelfiles/
├── README.md
├── mac-m3-24gb/
│   ├── gemma4-26b-moe.txt
│   ├── gemma4-31b-dense.txt
│   └── qwen3.5-27b-dense.txt
├── pc-rtx5090-32gb/
│   ├── gemma4-26b-moe.txt
│   ├── gemma4-31b-dense.txt
│   ├── qwen3.5-27b-dense.txt
│   └── qwen3.5-35b-moe.txt
└── scripts/
    └── ollama-network-expose.ps1
```

## Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| `num_ctx` | varies by model/hardware | Maximum context length in tokens |
| `num_predict` | 2048 / 4096 | Maximum response length |
| `temperature` | 0.2 | Low = more deterministic, precise code output |
| `repeat_penalty` | 1.1 | Prevents repetitive outputs |

## VS Code Copilot Chat

After setup, select the desired model in Copilot Chat:
- `gemma4-26b-coding`
- `gemma4-31b-coding`
- `qwen3.5-27b-coding`
- `qwen3.5-35b-coding` *(PC only)*

## Scripts

| Script | Platform | Description |
|--------|----------|-------------|
| `scripts/ollama-network-expose.ps1` | Windows (PowerShell) | Exposes the Ollama API on the local network |

```powershell
# Run from repo root in an elevated PowerShell session
powershell -ExecutionPolicy Bypass -File .\scripts\ollama-network-expose.ps1
```