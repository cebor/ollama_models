---
description: "Use when creating, editing, or reviewing Ollama Modelfiles (.txt) or updating the README. Enforces hardware-aware context window limits, required parameters, repo structure, and documentation conventions for the mac-m3-24gb and pc-rtx5090-32gb machines."
applyTo: "**/*.txt"
---

# Ollama Modelfile Conventions

## Hardware Specs (source of truth)

| Machine | Folder | RAM | VRAM |
|---------|--------|-----|------|
| MacBook M3 | `mac-m3-24gb/` | 24 GB Unified Memory | — |
| PC RTX 5090 | `pc-rtx5090-32gb/` | 64 GB RAM | 32 GB VRAM |

## Context Window Limits

Never exceed these values. They are derived from available memory.

| Model | mac-m3-24gb | pc-rtx5090-32gb |
|-------|-------------|-----------------|
| gemma4:26b (MoE, ~18 GB) | 16384 | 65536 |
| gemma4:31b (Dense, ~21 GB) | 8192 *(4096 if unstable)* | 32768 |

## Required Parameters

Every Modelfile must include all four parameters in this order:

```
FROM <base-model>

PARAMETER num_ctx <value>
PARAMETER num_predict <value>
PARAMETER temperature 0.2
PARAMETER repeat_penalty 1.1
```

- `num_predict`: use `2048` for mac, `4096` for pc
- `temperature` and `repeat_penalty` are fixed across all files

## Repo Structure

- Always create files in **both** machine folders when adding or modifying a model
- Filename pattern: `<model-name>-<variant>.txt` (e.g. `gemma4-26b-moe.txt`)
- Never add a model file for only one machine

## README Conventions

- Keep the Models table in sync with any new `.txt` files added
- List `num_ctx` values for both machines in the table
- Include size in Q4_K_M quantization
- Add a note if a model is memory-constrained on Mac
