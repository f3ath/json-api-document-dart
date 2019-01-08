# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.6] - 2019-01-07
### Added
- `preferResource` flag in `DataDocument.fromJson()`
- Friendlier `toString()`

## [0.3.5] - 2019-01-05
### Added
- PrimaryData and its subclasses are now exposed

## [0.3.4] - 2019-01-05
### Fixed
- `Document.fromJson` does not recognize null resource id

## [0.3.3] - 2019-01-05
### Added
- `Document.mediaType` constant

## [0.3.2] - 2018-11-05
### Changed
- Minor documentation improvements

## [0.3.0] - 2018-11-05
### Added
- Parsing capabilities.
- A few accessors to Meta, Attributes, Relationships

### Removed
- Link.isObject
- Link.meta

## [0.2.2] - 2018-10-09
### Added
- Enforce naming rules on relationships
- Included resources are checked for duplicates
- LinkObject
- Pagination links for data collection documents
- Resource fields uniqueness enforcement

##  [0.2.1] - 2018-10-05
### Added
- Compound documents
- Meta property to Identifier
- Prohibit creating empty `Api` objects

## 0.2.0 - 2018-10-03
### Added
- Initial usable implementation

[Unreleased]: https://github.com/f3ath/json-api-dart/compare/0.3.6...HEAD
[0.3.4]: https://github.com/f3ath/json-api-dart/compare/0.3.5...0.3.6
[0.3.4]: https://github.com/f3ath/json-api-dart/compare/0.3.4...0.3.5
[0.3.4]: https://github.com/f3ath/json-api-dart/compare/0.3.3...0.3.4
[0.3.3]: https://github.com/f3ath/json-api-dart/compare/0.3.2...0.3.3
[0.3.2]: https://github.com/f3ath/json-api-dart/compare/0.3.0...0.3.2
[0.3.0]: https://github.com/f3ath/json-api-dart/compare/0.2.2...0.3.0
[0.2.2]: https://github.com/f3ath/json-api-dart/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/f3ath/json-api-dart/compare/0.2.0...0.2.1
