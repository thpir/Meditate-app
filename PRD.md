# Product Requirements Document: Meditate App

| | |
|---|---|
| **Product** | Meditate App |
| **Product version** | 0.3.0+5 |
| **Last updated** | 2026-11-25 |
| **Owner** | thpir |
| **Related documents** | [README.md](README.md) (architecture, conventions, design system) · [CHANGELOG.md](CHANGELOG.md) (release history) |

## 1. About this document

This PRD records what the Meditate App does today and why. It is the reference for the product's behaviour: if the app and this document disagree, one of them is wrong.

- **Readers:** the owner, and AI coding agents working on the codebase.
- **Scope:** current behaviour only. Requirements describe the app *as it behaves*, rough edges included. Gaps are listed separately under [Known limitations](#10-known-limitations).
- **IDs:** every item has a stable ID: `FR-<AREA>-<NN>` for functional requirements, `NFR-<CATEGORY>-<NN>` for non-functional requirements and `KL-<NN>` for known limitations. IDs are never renumbered or reused. A dropped requirement keeps its ID and is marked *Removed*.
- **Out of scope:** code structure (MVVM, layers, naming) and the design system are documented in the README.
- **Keeping it current:** whenever app behaviour changes, update the affected requirements, the known limitations and the header above (see `CLAUDE.md`).

## 2. Product overview

### Vision

> A calm, private home for healthy daily habits and mindfulness, starting with meditation and hydration.

Meditation and water intake are the app's first two habits and are equal pillars. The product is meant to grow into a broader healthy-habits app, and every habit it adds should follow the same calm, private and simple approach.

### Problem

Many meditation and habit apps ask for an account, push subscriptions and bury the basics under content libraries and notifications. Someone who just wants a few quiet minutes, or a nudge to drink enough water, has to wade through all of that.

### Solution today

A free Android app that does a few things well:

- Start an unguided meditation with a calming background sound in a single tap.
- Log water in one tap and watch progress toward a personal daily goal.
- Add a personal touch with a display name and an avatar.
- Keep everything on the device: no account, no network, no tracking.

### Product principles

1. **Calm:** soft colours, rounded shapes and gentle animations. Nothing urgent or noisy.
2. **Simple:** every feature works in as few taps as possible, and nothing has to be set up before first use.
3. **Private:** all data stays on the device.
4. **Free:** every feature is available to everyone. Support comes only through optional donations.
5. **Offline:** the app never needs a connection.

## 3. Target users

| User group | What they need | How the app serves them today |
|---|---|---|
| Meditation beginners | An easy, non-intimidating way to start | Pick a duration and a sound, tap play. No courses or jargon. |
| Experienced meditators | A distraction-free timer for unguided practice | Minimal session screen, a looping sound or silence, vibration at the end |
| Wellness / habit seekers | Simple tools to build healthy daily routines | Meditation and daily water tracking side by side |
| Busy professionals | Short sessions that fit into a workday | Sessions from 5 minutes, one-tap water logging |

## 4. Goals and non-goals

### Goals

- **G-1** Start an unguided meditation session with a single tap from Home, with the last-used duration and sound preselected.
- **G-2** Make logging water quick and satisfying, with clear progress toward a personal daily goal.
- **G-3** Feel personal and calm (name, avatar, soft visual style).
- **G-4** Work fully offline and privately, without an account.
- **G-5** Stay free for everyone.

### Non-goals

These are deliberate product decisions, not missing features:

- **NG-1 No accounts or cloud sync.** No sign-up, login, backend or sync between devices.
- **NG-2 No ads, analytics or tracking.** No advertising, analytics, crash reporting or other third-party tracking SDKs.
- **NG-3 No paid features.** No in-app purchases, subscriptions or paywalls. Donations (Buy Me a Coffee) stay optional and outside the app.

## 5. Platform and distribution

| | |
|---|---|
| **Supported platform** | Android |
| **Distribution** | APK on [GitHub Releases](https://github.com/thpir/Meditate-app/releases) |
| **Application ID** | `com.thpir.meditate_app` |
| **Minimum Android version** | Flutter's default `minSdkVersion` |
| **Orientation** | Portrait and landscape |
| **Language** | English |
| **Theme** | Light only |
| **Licence** | MIT |

The repository also contains an iOS project, but iOS isn't supported or distributed (see KL-15).

## 6. Screens and navigation

```
Loading ──▶ Home ──┬─▶ Meditation session    (play button)
                   ├─▶ Water intake          (drop icon, top right)
                   └─▶ Menu (top left) ──┬─▶ User settings
                                         └─▶ Pick an avatar
```

Every screen except Home has a back arrow in the top-left corner that returns to Home. The system back gesture does the same.

## 7. Functional requirements

### 7.1 App start (FR-APP)

*Source: `lib/main.dart`, `lib/data/repositories/user_preferences.dart`*

**FR-APP-01 · Loading screen**
While the stored preferences load, the app shows a loading screen.
- The loading screen shows a spinner on the lavender background.
- Once the preferences have loaded (or failed to load, see NFR-REL-01), Home replaces the loading screen.

**FR-APP-02 · First-launch defaults**
On first launch (nothing stored yet) the app uses these values:

| Setting | Default |
|---|---|
| Display name | empty |
| Avatar | Sofie (the first avatar) |
| Meditation duration | 5 minutes |
| Background sound | None |
| Daily water goal | 2.00 L |
| Selected water volume | 200 ml |
| Today's water intake | 0 ml |

- No onboarding or setup step is shown: Home opens directly.

**FR-APP-03 · Choices persist**
Every user choice is stored on the device right away and restored on the next launch.
- After changing any setting from sections 7.2 to 7.5 and restarting the app, the changed value is shown.
- Exceptions: session progress isn't stored (FR-SES-08), and water intake is kept only for the current day (FR-WAT-08).

### 7.2 Home (FR-HOME)

*Source: `lib/ui/home/`*

**FR-HOME-01 · Greeting**
- Home shows the selected avatar in a large ringed circle, with the text "Welcome {name}" below it.
- A changed name or avatar shows on Home as soon as the user returns to it.
- With an empty name, the text reads "Welcome " (see KL-10).

**FR-HOME-02 · Duration picker**
- A dropdown with a timer icon offers 12 durations, from 5 to 60 minutes in 5-minute steps, labelled "5 minutes" to "60 minutes".
- The dropdown shows the current selection. Picking an option saves it right away.

**FR-HOME-03 · Sound picker**
- A dropdown with a music-note icon offers "None" plus 13 background sounds: Ambient, Bell, Birds, Campfire, Kerri Catalpa, Meditation Bowls, Metronome, Ocean, Pad Sound, Pure, River, Tibetan Bells and Uplifting.
- Picking an option saves it right away.
- Choosing a sound doesn't play a preview.

**FR-HOME-04 · Start a session**
- A round play button opens the Meditation session screen with the selected duration and sound.
- In portrait, the avatar animates from Home into the session screen (hero transition).

**FR-HOME-05 · Menu**
- A menu icon (top left) opens a popup with "User settings" and "Pick an avatar". Each item opens its screen.

**FR-HOME-06 · Water intake shortcut**
- A drop icon (top right, tooltip "Water intake") opens the Water intake screen.

### 7.3 Meditation session (FR-SES)

*Source: `lib/ui/meditation_session/`, `lib/data/services/audio_service.dart`*

**FR-SES-01 · Automatic start**
- When the session screen opens, the timer starts and the selected sound (if any) starts playing, with no extra tap.

**FR-SES-02 · Timer display**
- A circular control shows a play/pause icon, the elapsed time as `mm:ss` (large) and the total duration as `mm:ss` (small, e.g. `15:00`).
- The elapsed time counts **up** from `00:00`, one step per second while the session runs.
- The avatar is shown above the control in portrait and to its left in landscape.

**FR-SES-03 · Progress ring**
- A ring inside the control fills clockwise in proportion to elapsed time over total duration, and is full at the end.

**FR-SES-04 · Pause and resume**
- Tapping the icon while running pauses the timer and the sound, and the icon changes to play.
- Tapping it while paused resumes both from where they stopped, and the icon changes to pause.

**FR-SES-05 · Background sound**
- The selected sound loops without a break until the session ends or the user leaves.
- With "None", the session is silent.
- If the sound can't be loaded or played, the session carries on silently (NFR-REL-02).

**FR-SES-06 · Screen stays on**
- The screen doesn't turn off while the session screen is open, whether the session is running or paused.
- Leaving the session screen restores the normal screen timeout.

**FR-SES-07 · End of session**
When the elapsed time reaches the total duration:
- The timer and the sound stop.
- The elapsed time resets to `00:00`, the ring empties and the play icon is shown.
- If the device has a vibrator, it vibrates with the pattern 400 ms on, 200 ms off, 400 ms on, 200 ms off, 800 ms on.
- The user stays on the session screen. Tapping play starts a new run with the same duration and sound.
- The completed session isn't recorded anywhere (KL-01).

**FR-SES-08 · Leaving a session**
- The back arrow (top left) or the system back gesture returns to Home at any time, without confirmation.
- Leaving stops the timer and the sound immediately, and the progress is discarded.

### 7.4 Water intake (FR-WAT)

*Source: `lib/ui/water_intake/`, `lib/ui/core/ui/water_intake_view.dart`, `lib/ui/core/ui/water_painter.dart`, `lib/data/repositories/water_intake_repository.dart`*

**FR-WAT-01 · Screen**
- Opened from the drop icon on Home (FR-HOME-06). The screen is titled "Water intake" and has a back arrow.
- A spinner is shown while today's intake loads.

**FR-WAT-02 · Progress visual**
- A ringed circle shows animated water. Its level is today's intake divided by the daily goal.
- A percentage label inside the circle shows the progress rounded down, so it only reads 100% once the goal has actually been reached.
- Above 100%, the circle stays full and the label keeps counting (e.g. 120%).
- At 0%, the drop icon inside the circle pulses gently.
- When the screen opens, the water rises from empty to the current level. Every later change animates from the old level to the new one.
- When the system setting to remove animations is on, the level is shown without animation (NFR-A11Y-02).

**FR-WAT-03 · Amount label**
- Below the circle, a label shows today's intake and the goal in litres with two decimals, e.g. `1.20 L / 2.00 L`.

**FR-WAT-04 · Volume presets**
- Five chips offer 50 ml, 100 ml, 200 ml, 300 ml and 500 ml. Exactly one is selected (shown dark). The default is 200 ml.
- Tapping a chip selects it. The selection is stored and restored on the next launch.

**FR-WAT-05 · Add water**
- Tapping **+** adds the selected volume to today's intake and stores the new total right away.
- There is no upper limit.

**FR-WAT-06 · Remove water**
- Tapping **−** subtracts the selected volume and stores the new total right away.
- The intake never goes below 0 ml (e.g. 150 ml − 200 ml = 0 ml).

**FR-WAT-07 · Goal follows settings**
- The goal is the daily water goal from User settings (FR-PRO-03). Changing it updates the label and the visual.

**FR-WAT-08 · Daily reset**
- Today's intake belongs to the device's local calendar date.
- When the stored intake belongs to any other date, it resets to 0 ml. The app checks this at app start, when the Water intake screen opens, when the app returns to the foreground while that screen is open, and before every + or −.
- The selected volume is kept across days.

**FR-WAT-09 · No history**
- Only today's total is kept. Earlier days are discarded on reset (KL-07).

### 7.5 Profile and settings (FR-PRO)

*Source: `lib/ui/user_settings/`, `lib/ui/pick_avatar/`*

**FR-PRO-01 · User settings screen**
- Opened from the Home menu ("User settings"). The screen is titled "User settings" and has a back arrow.

**FR-PRO-02 · Display name**
- A text field (hint "Enter your name") is prefilled with the current name.
- Every keystroke is saved right away. There is no save button.
- There is no validation: any text is accepted, including an empty name, and there is no length limit.

**FR-PRO-03 · Daily water goal**
- A dropdown with a drop icon offers 13 goals, from "1.00 L per day" to "4.00 L per day" in 0.25 L steps. The default is 2.00 L.
- Picking a goal saves it right away.

**FR-PRO-04 · Pick an avatar**
- Opened from the Home menu ("Pick an avatar"). The screen is titled "Pick an avatar" and has a back arrow.
- It shows all 12 illustrated avatars as circles in a scrollable grid. The selected avatar has a badge. (The avatars have internal names: Sofie, Luna, Maya, Zara, Leo, Kai, Ava, Ezra, Jax, Nova, Milo and Sage. These names aren't shown in the UI.)
- Tapping an avatar selects it and saves it right away. The user stays on the screen.
- The selected avatar is shown on Home and in the session screen.

## 8. Data and persistence

All data is stored on the device with `shared_preferences`. A choice is stored as its option's stable `id` or as its value in ml, never as its position in the list (see README › Layers › Domain models).

| Key | Stores | Value when missing or unknown |
|---|---|---|
| `name` | Display name (text) | `""` |
| `avatar` | `Avatar` id | `0` → Sofie |
| `duration` | `MeditationDuration` id | `0` → 5 minutes |
| `sound` | `MeditationSound` id | `0` → None |
| `water_goal_ml` | Daily goal in ml | Any value that isn't a listed goal → 2000 ml |
| `water_volume_ml` | Selected volume in ml | Any value that isn't a listed volume → 200 ml |
| `water_intake_ml` | Today's total in ml | `0` |
| `water_intake_date` | Date of that total (`yyyy-MM-dd`) | `""` → treated as another day, so the intake resets to 0 |

Fallback behaviour:

- If reading the user preferences fails, or a stored avatar, duration or sound id matches no option, **all** user preferences (name, avatar, duration, sound and water goal) fall back to the defaults of FR-APP-02 for that launch. Stored values aren't overwritten until the user changes them (KL-09).
- If reading the water data fails, the intake is 0 ml, the date is empty and the selected volume is 200 ml.
- Save failures are logged. The change still applies in memory while the app runs.

## 9. Non-functional requirements

### Privacy (NFR-PRIV)

- **NFR-PRIV-01** All data stays on the device. The app has no account, backend, analytics, ads or crash reporting, and sends no data anywhere.
- **NFR-PRIV-02** The release build requests only the `VIBRATE` permission. It doesn't request `INTERNET`: only the debug and profile builds do, for development tooling.

### Offline (NFR-OFF)

- **NFR-OFF-01** Every feature works without a network connection. All sounds, images and fonts are bundled with the app.

### Reliability (NFR-REL)

- **NFR-REL-01** A storage failure never blocks the app. On a read error the app falls back to defaults (section 8) and stays usable. Errors are logged through `LoggingService`.
- **NFR-REL-02** An audio failure never blocks a session. If a sound can't be loaded or played, the session runs silently. Errors are logged.
- **NFR-REL-03** Water intake is saved right after every + or −, so it survives the app being closed.

### Responsiveness (NFR-PERF)

- **NFR-PERF-01** User actions update the UI immediately. Saving happens in the background and doesn't hold up the UI.
- **NFR-PERF-02** Start-up doesn't depend on the network: the loading screen only waits for local storage.

### Accessibility (NFR-A11Y)

- **NFR-A11Y-01** The Water intake screen has screen-reader labels: the circle reads "Water intake N% of daily goal", the buttons read "Add {volume}" and "Remove {volume}", and the chips announce their selected state. The drop icon on Home has the tooltip "Water intake".
- **NFR-A11Y-02** The water animation respects the system setting to remove animations.

### Layout (NFR-LAY)

- **NFR-LAY-01** Home, Meditation session and Water intake adapt to orientation: content is stacked in portrait and side by side in landscape. Circular elements scale to the available space.
- **NFR-LAY-02** User settings and Pick an avatar scroll when their content doesn't fit.

### Power (NFR-PWR)

- **NFR-PWR-01** The screen is kept awake only while the session screen is open (FR-SES-06).

## 10. Known limitations

These are gaps in the current behaviour. They're listed here so the requirements above can stay accurate, and they aren't commitments to change anything.

| ID | Limitation | Affects |
|---|---|---|
| KL-01 | Completed sessions aren't recorded: there is no history, statistics or streaks. | FR-SES-07 |
| KL-02 | A session ends without a completion screen or message: the timer silently resets to `00:00`. | FR-SES-07 |
| KL-03 | There's no end-of-session signal on devices without a vibrator or with vibration turned off, and there's no end sound. | FR-SES-07 |
| KL-04 | The timer counts one-second delays instead of measuring real elapsed time, so it can drift during long sessions. | FR-SES-02 |
| KL-05 | Sessions don't handle the app lifecycle: there's no background audio service and no lock-screen or notification controls, and nothing defines what happens while the app is in the background or the screen is locked. | FR-SES-01, FR-SES-05 |
| KL-06 | Leaving a session asks for no confirmation, and the progress is lost. | FR-SES-08 |
| KL-07 | Water intake keeps only today's total: there's no history. | FR-WAT-09 |
| KL-08 | The daily reset uses the device's local date, so changing the clock or time zone can trigger or skip a reset. | FR-WAT-08 |
| KL-09 | One invalid stored preference resets all user preferences, including the name, to defaults for that launch. Storage errors are only logged, and the user isn't told. | Section 8, NFR-REL-01 |
| KL-10 | No onboarding asks for a name, so with an empty name Home reads "Welcome ". | FR-APP-02, FR-HOME-01 |
| KL-11 | Durations are fixed (5–60 minutes in 5-minute steps): there's no custom duration and no interval bells. | FR-HOME-02 |
| KL-12 | There are no reminders or notifications for meditating or drinking water. | FR-SES, FR-WAT |
| KL-13 | Screen-reader labels exist only on the Water intake screen. For example, the play buttons on Home and in the session have no accessible label. | NFR-A11Y-01 |
| KL-14 | The app is English only and has a light theme only (no dark mode). | Section 5 |
| KL-15 | Android only: the repository contains an iOS project, but iOS isn't supported or distributed. | Section 5 |
