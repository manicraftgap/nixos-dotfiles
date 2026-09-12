# Tmux Keybindings Reference

> **Leader Key (`Prefix`):** `Ctrl + a`

---

## 1. System & Session Management

| Keybinding | Action |
| :--- | :--- |
| `Prefix` + `r` | Reload `~/.tmux.conf` configuration |
| `Prefix` + `d` | Detach from active session |
| `Prefix` + `:` | Open Tmux command prompt |

---

## 2. Window Management (Tabs)

| Keybinding | Action |
| :--- | :--- |
| `Prefix` + `c` | Create new window |
| `Prefix` + `,` | Rename current window |
| `Prefix` + `&` | Kill current window |
| `Alt` + `1`–`9` | Switch directly to Window 1 through 9 *(No Prefix)* |

---

## 3. Pane Management (Splits)

| Keybinding | Action |
| :--- | :--- |
| `Prefix` + `v` | Split pane vertically *(side-by-side)* |
| `Prefix` + `s` | Split pane horizontally *(top/bottom)* |
| `Alt` + `h` / `j` / `k` / `l` | Move focus Left / Down / Up / Right *(No Prefix)* |
| `Prefix` + `h` / `j` / `k` / `l` | Move focus Left / Down / Up / Right |
| `Prefix` + `Shift` + `H` / `J` / `K` / `L` | Resize active pane by 5 cells |
| `Prefix` + `z` | Toggle full-screen zoom on focused pane |
| `Prefix` + `x` | Kill active pane |

---

## 4. Copy Mode & Clipboard (Neovim-Style)

| Keybinding | Action |
| :--- | :--- |
| `Prefix` + `[` | Enter Copy Mode |
| `v` | Begin text selection *(Inside Copy Mode)* |
| `Ctrl` + `v` | Toggle rectangular visual block selection |
| `y` | Yank selection to system clipboard and exit Copy Mode |
| `q` | Exit Copy Mode |

---

## 5. Workmux Quick Reference

> Executed directly in your shell terminal/pane.

```bash
# Create a new branch & worktree window
workmux add <branch-name>

# Create workspace and seed an AI agent prompt
workmux add -A "<prompt>"

# Switch active window to a worktree
workmux switch <branch-name>

# List active worktrees & agent statuses
workmux list

# Merge, clean up worktree, and close window
workmux merge

# Force remove worktree and window without merging
workmux remove <branch-name>
