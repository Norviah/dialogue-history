## [v2.0.2](https://github.com/Norviah/dialogue-history/compare/v2.0.0...v2.0.2) (2025-10-06)

### Bug Fixes

- add compatibility with the menu item for the hotscenes mod <code>[dd10a5d](https://github.com/Norviah/dialogue-history/commit/dd10a5db6639a917f7c614438b469da71d03d1eb)</code>

### Build System

- **bump**: add `localization` commit type <code>[7346422](https://github.com/Norviah/dialogue-history/commit/73464229bae3fcadc7b9d550539aa11d59d535d9)</code>

### Localization

- add localization keys for the various dialogue line types <code>[46b8b52](https://github.com/Norviah/dialogue-history/commit/46b8b5233a14d40cc0f9a5bb5636d2b4f6e350fc)</code>

- make the menu item point to the localization key "DialogueHistory-Title" <code>[58528e3](https://github.com/Norviah/dialogue-history/commit/58528e3b291070c8acfd754610d18397771d337a)</code>

## [v2.0.0](https://github.com/Norviah/dialogue-history/compare/v1.1.2...v2.0.0) (2025-09-23)

## [v1.1.2](https://github.com/Norviah/dialogue-history/compare/v1.1.1...v1.1.2) (2025-01-10)

### Bug Fixes

- ignore subtitles that were drawn twice <code>[63c41fd](https://github.com/Norviah/dialogue-history/commit/63c41fd02ed771e9aa57b05851636245d59d4acd)</code>

## [v1.1.1](https://github.com/Norviah/dialogue-history/compare/v1.1.0...v1.1.1) (2025-01-07)

### Bug Fixes

- decrease the wrapping width to prevent text overflow when also showing a line's timestamp <code>[769db36](https://github.com/Norviah/dialogue-history/commit/769db36a3a9f9189b381a6e40ed39da76fd771d4)</code>

## [v1.1.0](https://github.com/Norviah/dialogue-history/compare/v1.1.0-rc4...v1.1.0) (2025-01-07)

### Build System

- add support for `ui` commit type <code>[ef03909](https://github.com/Norviah/dialogue-history/commit/ef03909545de70eab5306fdb14b0dabdb41ed91d)</code>

### Bug Fixes

- consider `OverHeadAlwaysVisible` to determine if a line represents an overhead subtitle <code>[0797275](https://github.com/Norviah/dialogue-history/commit/0797275c72d62ec038d8caa58fceaa8562928c3d)</code>

- let escape/right-click/etc. cancel prompts <code>[5c41ec4](https://github.com/Norviah/dialogue-history/commit/5c41ec4138a57a6ff06c4d89d03ede64dc5e1396)</code>

### Features

- **colors**: add `Grey` and `DarkGrey` <code>[4709997](https://github.com/Norviah/dialogue-history/commit/470999770798a91d1f8a598e80f4c470b38fbed2)</code>

- store timestamp for lines <code>[a5b82b6](https://github.com/Norviah/dialogue-history/commit/a5b82b6966958d8b56a209c49ef89cbe6ea7b060)</code>

- **localization**: add french translation <code>[8d826c4](https://github.com/Norviah/dialogue-history/commit/8d826c4effdd680110f0267752488f31ea58b7bf)</code>

	thank you to Gigowatt221

### UI

- change the opening transition for lines to a fade-in <code>[2c6ec4f](https://github.com/Norviah/dialogue-history/commit/2c6ec4fbd3a9724138d4fa5dbf1e0e1796ca698f)</code>

## [v1.1.0-rc4](https://github.com/Norviah/dialogue-history/compare/v1.1.0-rc3...v1.1.0-rc4) (2025-01-04)

### Features

- persist logs between game sessions <code>[d393b17](https://github.com/Norviah/dialogue-history/commit/d393b17f0aacc352c8f40e769d11879cfe7b91be)</code>

## [v1.1.0-rc3](https://github.com/Norviah/dialogue-history/compare/v1.1.0-rc2...v1.1.0-rc3) (2025-01-04)

### Bug Fixes

- **menu**: create a `RefreshLogEvent` event when clearing the current day's log to refresh both the sidebar and textarea <code>[dba5d7b](https://github.com/Norviah/dialogue-history/commit/dba5d7b440ab31fb8506a6a0f0bfbb3532bbc5e6)</code>

## [v1.1.0-rc2](https://github.com/Norviah/dialogue-history/compare/v1.1.0-rc1...v1.1.0-rc2) (2025-01-04)

### Refactor

- **localization**: update int placeholders from `{num}` to `{int}` <code>[996f111](https://github.com/Norviah/dialogue-history/commit/996f1111fb13fb09bbd0cb358ff5ad557c5598cd)</code>

### Features

- **localization**: create localization keys for some config options <code>[a77c382](https://github.com/Norviah/dialogue-history/commit/a77c3821f52b74b391ff12db1e281449a05693b2)</code>

### Build System

- **scripts/import**: delete all mod files before importing <code>[ff048a0](https://github.com/Norviah/dialogue-history/commit/ff048a08b82b62dcec1bdc28649d99987dba536f)</code>

## [v1.1.0-rc1](https://github.com/Norviah/dialogue-history/compare/v1.0.2...v1.1.0-rc1) (2025-01-03)

### Features

- v1.1.0-rc1 <code>[601d324](https://github.com/Norviah/dialogue-history/commit/601d32468cab7e2eb7ca50b8d38b611111f4b278)</code>

### Build System

- update scripts <code>[7a816b7](https://github.com/Norviah/dialogue-history/commit/7a816b7d600c3dccb264485269429a26a57333a3)</code>

## [v1.0.2](https://github.com/Norviah/dialogue-history/compare/v1.0.1...v1.0.2) (2024-12-27)

### Build System

- **changelog**: include commit body when generating changelogs <code>[31ce6ad](https://github.com/Norviah/dialogue-history/commit/31ce6ad282533c11b8a7b824f3c0dda7eb4f51da)</code>

### Features

- **localization**: add simplified chinese translation <code>[c523848](https://github.com/Norviah/dialogue-history/commit/c523848186229eddc2e8532480b35c15139056c5)</code>

	thank you to Felix

## [v1.0.1](https://github.com/Norviah/dialogue-history/compare/v1.0.0...v1.0.1) (2024-12-24)

### Bug Fixes

- **redscript**: use `ModLog` for logging purposes to prevent errors <code>[033c205](https://github.com/Norviah/dialogue-history/commit/033c205a3019bab7491f15b88ab2bbbc7eed5958)</code>

## v1.0.0 (2024-12-23)