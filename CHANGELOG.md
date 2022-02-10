#####

# Changelog

All notable changes to "Au3TestFramework" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Go to [legend](#legend---types-of-changes) for further information about the types of changes.

## [0.16.0] - 2022-02-10

### Added

- Links to the project badges/icons.
- FAQ section to README.md file.

### Changed:

- Move "Keyboard shortcuts" section into "Getting started" section (as sub section after "Usage").
- Version bump.

## [0.15.0] - 2022-02-09

### Changed

- Update copyright year to 2022 in LICENSE.md file.
- Update of documents/templates (bug report-, feature request- and pull request template).
- Update of the contributing file.
- Code of Conduct update to their version v2.1.
- Version bump.

### Removed

- Unnecessary documents/templates in docs directory.

## [0.14.0] - 2021-10-22

### Added

- First approach of a Test Explorer program, called "TestExecutor", as GUI.
- Visualization of all features, scenarios, the execution state and execution duration (still WIP).
- Library "GUIScroll.au3" (utilities).

### Changed

- Minor function adjustments for the StepGenerator.

## [0.13.0] - 2021-10-19

### Added

- Compiler information to executable.

## [0.12.0] - 2021-10-19

### Changed

- Scenario step wrapper functions contain a message box instead of only a comment of "your code pending".

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

[0.15.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.14.0...v0.15.0
[0.14.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.13.0...v0.14.0
[0.13.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.12.0...v0.13.0
[0.12.0]: https://github.com/Sven-Seyfert/Au3TestFramework/compare/v0.11.0...v0.12.0
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
- `Fixed` for any bug fixes.
- `Removed` for now removed features.
- `Security` in case of vulnerabilities.

##

[To the top](#)
