# Changelog

All notable changes to "Au3TestFramework" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.11.0] - 2021-10-12

### Added

- One example feature file (ExampleInvalidByQuotes.feature) for the demonstration of wrong single quote count issue.
- Check for duplicate scenario steps (which is invalid).
- Handling possible duplicate scenario steps during the creation of the scenario step wrapper methods.

### Changed

- Titles and texts for exception handling messages.
- Renaming of the example feature files.

## [0.10.0] - 2021-10-11

### Added

- Language resource file (TextContainer.au3) to prepare multilingualism of the programs.

### Changed

- General code improvements (cleaner).
- Renaming and restructuring of source files.
- Restructuring of functions into the separate source files.

## [0.9.1] - 2021-10-08

### Changed

- Example texts in Feature file (in Scenario Steps).

### Fixed

- Parameter creation logic to get function parameter and table parameter for the wrapper functions again.

## [0.9.0] - 2021-10-08

### Changed

- AutoIt Code formatting to the common notation without additional spaces after opened brackets and before closed brackets.

## [0.8.0] - 2021-08-24

### Added

- All repository data and dependencies (already added before in version v0.8.0).

[0.11.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.9.1...v0.10.0
[0.9.1]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/Sven-Seyfert/Au3TestFramework/releases/tag/v0.8.0

---

### Legend - Types of changes
- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.
