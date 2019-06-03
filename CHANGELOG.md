# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- `JsonApiError` fields are now final
- Bumped min Dart SDK version to 2.3.0

### Added
- `Resource.withId()`

## [1.0.2] - 2019-04-13
### Fixed
- `ToMany.toIdentifiers()` should return `List`

## [1.0.1] - 2019-04-03
### Fixed
- Do not send id:null in ResourceObject ([#58](https://github.com/f3ath/json-api-document-dart/issues/58))

## [1.0.0] - 2019-03-29
### Changed
- Nothing. Just a formal v1 release

## [0.6.0] - 2019-03-25
### Changed
- Renamed the main library file: `document.dart -> json_api_document.dart`

## [0.5.0] - 2019-03-24
### Changed
- Total BC-breaking rewrite of the library. It is split into 3 parts: the document, the parser and the validator.

## [0.3.10] - 2019-01-20
### Added
- Exposed `Relationship` class

## [0.3.9] - 2019-01-08
### Fixed
- Bug when IdentifierList data could not be parsed due to insufficient type information in runtime

## [0.3.8] - 2019-01-07
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

[Unreleased]: https://github.com/f3ath/json-api-document-dart/compare/1.0.2...HEAD
[1.0.2]: https://github.com/f3ath/json-api-document-dart/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/f3ath/json-api-document-dart/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/f3ath/json-api-document-dart/compare/0.6.0...1.0.0
[0.6.0]: https://github.com/f3ath/json-api-document-dart/compare/0.5.0...0.6.0
[0.5.0]: https://github.com/f3ath/json-api-document-dart/compare/0.3.10...0.5.0
[0.3.10]: https://github.com/f3ath/json-api-document-dart/compare/0.3.9...0.3.10
[0.3.9]: https://github.com/f3ath/json-api-document-dart/compare/0.3.8...0.3.9
[0.3.8]: https://github.com/f3ath/json-api-document-dart/compare/0.3.5...0.3.8
[0.3.5]: https://github.com/f3ath/json-api-document-dart/compare/0.3.4...0.3.5
[0.3.4]: https://github.com/f3ath/json-api-document-dart/compare/0.3.3...0.3.4
[0.3.3]: https://github.com/f3ath/json-api-document-dart/compare/0.3.2...0.3.3
[0.3.2]: https://github.com/f3ath/json-api-document-dart/compare/0.3.0...0.3.2
[0.3.0]: https://github.com/f3ath/json-api-document-dart/compare/0.2.2...0.3.0
[0.2.2]: https://github.com/f3ath/json-api-document-dart/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/f3ath/json-api-document-dart/compare/0.2.0...0.2.1
