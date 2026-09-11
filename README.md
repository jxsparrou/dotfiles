# Quickshell Configuration

A work-in-progress custom desktop shell for **CachyOS + Hyprland**,
built with [Quickshell](https://quickshell.org/).

The goal is to gradually replace the day-to-day shell functionality
currently provided by Noctalia with a smaller, personal Quickshell
configuration while keeping the existing Hyprland setup as the source of
truth for compositor behavior.

> **Status:** Early development. Noctalia is still the known-good
> fallback and should not be removed yet.

## Current Features

The shell currently provides:

-   One bar per connected monitor
-   Monitor-aware Hyprland workspaces
-   Clock
-   System tray
    -   Left-click activation
    -   Right-click native tray menus
    -   Tray menu positioning still needs refinement
-   Network status
    -   Detects the active NetworkManager device
    -   Displays Ethernet or the Wi-Fi network name
-   PipeWire volume control
    -   Live volume percentage
    -   Muted state
    -   Left-click to mute/unmute
    -   Mouse wheel changes volume in 5% steps

The current root shell creates a `PanelWindow` for each screen and
composes the individual bar components from `Bar/`.

## Requirements

This configuration is being developed for a **normal CachyOS
Hyprland/Noctalia installation**. Much of the underlying desktop stack
(Hyprland, PipeWire, NetworkManager, Qt 6, Wayland, icon support, etc.)
should already be present there.

### Additional packages

The main additional package required by this configuration is:

``` bash
sudo pacman -S quickshell
```

This project is currently developed against **Quickshell 0.3.1**.

CachyOS/Arch packages pull in Quickshell's required Qt, Wayland,
PipeWire, SVG, and related runtime libraries automatically.

> **Noctalia note:** Some CachyOS Noctalia installations may use
> `noctalia-qs`, a custom Quickshell fork which provides `quickshell`
> and conflicts with the standard `quickshell` package. Check your
> existing setup with `quickshell --version` and your installed packages
> before replacing anything. Do not remove Noctalia or its Quickshell
> dependency just to try this configuration.

If this repository is managed the same way as the author's dotfiles,
also install:

``` bash
sudo pacman -S git stow
```

`stow` is only required for the dotfiles/symlink workflow; Quickshell
itself does not require it.

### Services expected to be available

The current shell expects:

-   **Hyprland** --- workspace and monitor integration
-   **PipeWire** --- audio state and volume control
-   **NetworkManager** --- networking state through Quickshell's native
    networking API
-   A working **system tray / StatusNotifierItem** environment for tray
    applications

These are normally already present in the target CachyOS
Hyprland/Noctalia environment.

## Installation

If using this repository with GNU Stow, clone the dotfiles repository
into your home directory and stow the Quickshell package from the
repository root:

``` bash
git clone <your-dotfiles-repository> ~/dotfiles
cd ~/dotfiles
stow quickshell
```

The resulting configuration should resolve to:

``` text
~/.config/quickshell/
```

with `shell.qml` as the entry point.

Run it manually while developing/testing:

``` bash
quickshell -p "$HOME/.config/quickshell"
```

Quickshell watches its configuration files and normally reloads
automatically when they are saved.

The root configuration currently uses:

``` qml
//@ pragma UseQApplication
```

This is required for native system-tray menus. Changes to startup-level
pragmas may require restarting Quickshell rather than relying on hot
reload.

## Project Structure

``` text
~/.config/quickshell/
├── shell.qml
└── Bar/
    ├── Clock.qml
    ├── Network.qml
    ├── SysTray.qml
    ├── Volume.qml
    └── Workspaces.qml
```

As the project grows, the intended structure is roughly:

``` text
~/.config/quickshell/
├── shell.qml
├── Bar/
├── Components/
├── Menu/
├── Panels/
└── Services/
```

The goal is to keep compact bar controls separate from larger panels and
shared service/state logic.

## Roadmap

### Core shell

-   [x] Minimal Quickshell bar
-   [x] Multi-monitor bars
-   [x] Monitor-aware Hyprland workspaces
-   [x] Clock
-   [x] System tray
-   [x] Basic PipeWire volume control
-   [x] Basic network status
-   [ ] Reusable popup/panel architecture
-   [ ] Correct tray flyout positioning
-   [ ] Network panel
-   [ ] Expanded audio panel
-   [ ] Notifications
-   [ ] Power/session controls
-   [ ] Hierarchical launcher/menu
-   [ ] Shared visual components and final styling

### Expanded audio panel

Planned audio functionality includes:

-   Output volume slider and mute
-   Output device selection
-   Microphone/input level and mute
-   Input device selection
-   Per-application volume controls, if the Quickshell/PipeWire APIs
    support them cleanly
-   Optional shortcut to full system audio settings

### Networking

The network panel is planned to grow beyond the current bar indicator
with connection details and network controls.

**Stretch goal:** integrate **Tailscale** into the networking section,
potentially including connection state, Tailscale IP, tailnet
information, exit-node status, and useful quick actions. Tailscale is
not currently a dependency.

### Lower-priority / optional

-   Bluetooth integration
-   Clipboard functionality
-   OSDs
-   Lock/session integration
-   Additional system controls

Bluetooth is intentionally lower priority because it is not a major part
of the current desktop workflow.

## Design Goals

This project is intentionally being built incrementally rather than
starting from a large shell framework.

The general approach is:

1.  Get a small piece of functionality working with native Quickshell
    APIs.
2.  Keep Hyprland as the source of truth where appropriate.
3.  Prefer native Quickshell integrations over polling external CLI
    tools.
4.  Separate compact bar controls from richer popup panels.
5.  Establish reusable components only after repeated patterns become
    clear.
6.  Polish the visual design after the major functionality is in place.

The interaction design is influenced by polished Wayland shells and
hierarchical desktop menus, but the implementation is intended to remain
a clean, personal Quickshell configuration rather than a port of another
shell.

## Development Notes

The configuration currently uses native Quickshell integrations for:

-   `Quickshell.Hyprland`
-   `Quickshell.Services.Pipewire`
-   `Quickshell.Networking`
-   `Quickshell.Services.SystemTray`

The volume widget uses `PwObjectTracker` to bind the default PipeWire
sink so live audio properties such as volume and mute state remain
usable and reactive.

Named and persistent workspaces are not hard-coded into the shell. The
workspace widget reads the workspaces that Hyprland currently exposes
and filters them by monitor.

## Noctalia Migration

Noctalia should remain installed and available while this shell is under
development.

The migration strategy is to reproduce the shell functionality that is
actually useful first, test it alongside the existing setup, and only
consider removing or replacing Noctalia components once the custom shell
can reliably handle the required desktop functions.

Greeter, lock-screen, polkit, and other session-critical functionality
are intentionally outside the current migration scope.
