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
| gemma4:26b-a4b-it-q4_K_M (MoE, ~18 GB) | 16384 | 131072 |
| gemma4:31b-it-q4_K_M (Dense, ~21 GB) | 8192 | 65536 |
| qwen3.6:27b-q4_K_M (Dense, ~17 GB) | 8192 | 65536 |
| qwen3.6:35b-a3b-q4_K_M (MoE, ~24 GB) | — (PC only) | 131072|

## Required Parameters

Every Modelfile must include all four parameters in this order:

```
FROM <base-model>

PARAMETER num_ctx <value>
PARAMETER num_predict <value>
PARAMETER temperature <value>
PARAMETER repeat_penalty 1.1
```

- `num_predict`: use `2048` for mac, `8192` for pc
- `repeat_penalty` is fixed at `1.1` across all files
- `temperature` depends on model type:
  - **coding models** (MoE, e.g. `*-moe.txt`): `0.2` — deterministic, precise output
  - **planning models** (Dense, e.g. `*-dense.txt`): `0.5` — more creative reasoning

## Repo Structure

- Always create files in **both** machine folders when adding or modifying a model
- Filename pattern: `<model-name>-<variant>.txt` (e.g. `gemma4-26b-moe.txt`)
- Never add a model file for only one machine

## README Conventions

- Keep the Models table in sync with any new `.txt` files added
- List `num_ctx` values for both machines in the table
- Include size in Q4_K_M quantization
- Add a note if a model is memory-constrained on Mac
