# chase_DogEmotemenu

A lightweight dog ped emote menu for **QBCore / Qbox** FiveM servers. Allows players using dog ped models to play animations via a simple custom-drawn in-game menu — no NUI required.

---

## Preview

<!-- Replace with your actual screenshot -->
![Menu Preview](https://i.imgur.com/PLACEHOLDER.png)

---

## Features

- Works only when the player is using a supported dog ped model
- Clean in-game menu drawn with native GTA rendering (no HTML/NUI)
- 8 built-in dog animations
- Keyboard navigation (Arrow keys, Enter, Backspace/Escape)
- Movement automatically cancels the active emote
- Configurable key binding and dog model list

---

## Animations

| Name           | Dictionary                                          | Animation              |
|----------------|-----------------------------------------------------|------------------------|
| Lay Down       | `creatures@rottweiler@amb@sleep_in_kennel@`         | `sleep_in_kennel`      |
| Bark           | `creatures@rottweiler@amb@world_dog_barking@idle_a` | `idle_a`               |
| Sit            | `creatures@rottweiler@amb@world_dog_sitting@base`   | `base`                 |
| Itch           | `creatures@rottweiler@amb@world_dog_sitting@idle_a` | `idle_a`               |
| Draw Attention | `creatures@rottweiler@indication@`                  | `indicate_high`        |
| Attack         | `creatures@rottweiler@melee@`                       | `dog_takedown_from_back` |
| Taunt          | `creatures@rottweiler@melee@streamed_taunts@`       | `taunt_02`             |
| Swim           | `creatures@rottweiler@swim@`                        | `swim`                 |

---

## Supported Ped Models

- `a_c_shepherd`
- `a_c_rottweiler`
- `a_c_husky`
- `a_c_poodle`
- `a_c_pug`
- `a_c_westy`
- `a_c_retriever`
- `a_c_chop`
- `a_c_chop_02`

---

## Installation

1. Drop the `chase_DogEmotemenu` folder into your server's `resources` directory.
2. Add the following to your `server.cfg`:
   ```
   ensure chase_DogEmotemenu
   ```
3. Restart your server.

---

## Configuration

Edit `config.lua` to change the menu key or supported dog models:

```lua
Config.MenuKey = 'j'          -- Key to open the emote menu

Config.DogModels = {
    "a_c_shepherd",
    "a_c_rottweiler",
    -- add more models here
}
```

> **Note:** The default keybind is `J`. Players can rebind it in GTA V's Key Bindings settings under FiveM.

---

## Controls

| Action        | Key                    |
|---------------|------------------------|
| Open Menu     | `J` (default)          |
| Navigate Up   | Arrow Up               |
| Navigate Down | Arrow Down             |
| Select        | Enter / Numpad Enter   |
| Close         | Backspace / Escape     |
| Cancel Emote  | Any movement key (WASD)|

---

## Dependencies

- [QBCore](https://github.com/qbcore-framework/qb-core) or [Qbox](https://github.com/Qbox-project/qbx_core)

---

## License

This resource is provided as-is for personal and server use. Do not redistribute or resell without permission.
