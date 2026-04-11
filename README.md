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

> **Note (Mac):** The 31b Dense model leaves very little KV-cache headroom on 24 GB.
> If it becomes unstable, reduce `num_ctx` to `4096`. The 26b MoE is the better choice on Mac.

## Setup

```bash
# Pull models
ollama pull gemma4:26b
ollama pull gemma4:31b

# Create modelfiles — Mac
ollama create gemma4-26b-coding -f ./mac-m3-24gb/gemma4-26b-moe.txt
ollama create gemma4-31b-coding -f ./mac-m3-24gb/gemma4-31b-dense.txt

# Create modelfiles — PC
ollama create gemma4-26b-coding -f ./pc-rtx5090-32gb/gemma4-26b-moe.txt
ollama create gemma4-31b-coding -f ./pc-rtx5090-32gb/gemma4-31b-dense.txt

# Verify
ollama list
```

## Repository Structure
```
ollama-modelfiles/
├── README.md
├── mac-m3-24gb/
│   ├── gemma4-26b-moe.txt
│   └── gemma4-31b-dense.txt
└── pc-rtx5090-32gb/
├── gemma4-26b-moe.txt
└── gemma4-31b-dense.txt
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