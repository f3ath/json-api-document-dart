# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Api.fromJson()
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

[Unreleased]: https://github.com/f3ath/json-api-dart/compare/0.2.2...HEAD
[0.2.2]: https://github.com/f3ath/json-api-dart/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/f3ath/json-api-dart/compare/0.2.0...0.2.1
