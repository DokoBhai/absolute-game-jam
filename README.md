# Absolute Game Jam!!

A small Godot 4 project/prototype for Absolute Game Jam.

## Requirements

- Godot `4.6` (the project is configured with `config/features = ["4.6", "Forward Plus"]`).

## Run (Editor)

1. Open this folder in the Godot editor.
2. Press `F5` (Run Project).

## Controls

- Move: `ui_left` / `ui_right` (Godot default input map; typically Arrow keys or A/D).
- Jump: `ui_accept` (configured for Enter / Space / gamepad south button).

## Project Structure

- `scenes/` – main scenes (entry point: `main_scene.tscn`).
- `object_nodes/` – reusable scene objects (e.g. `player.tscn`).
- `scripts/` – gameplay scripts (e.g. `player.gd`).
- `assets/` – assets folder (currently empty).