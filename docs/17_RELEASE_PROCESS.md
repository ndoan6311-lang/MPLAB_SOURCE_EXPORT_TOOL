# RELEASE PROCESS

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC ĐÍCH

Tài liệu này quy định quy trình phát hành (Release Process) của dự án.

Mục tiêu

- Release ổn định
- Có thể truy vết
- Có thể rollback
- Không phát hành mã chưa kiểm thử
- Đảm bảo chất lượng

---

# NGUYÊN TẮC

Release chỉ được thực hiện khi:

- Feature hoàn thành
- Test Pass
- Review Pass
- Documentation cập nhật
- Đáp ứng Definition of Done

Không Release vì áp lực thời gian.

---

# RELEASE FLOW

Development

↓

Code Review

↓

Testing

↓

Regression Test

↓

Documentation Update

↓

Version Update

↓

Release Candidate

↓

Final Verification

↓

Git Tag

↓

Release

---

# RELEASE TYPE

## Patch Release

Ví dụ

1.0.0

↓

1.0.1

Áp dụng

- Bug Fix
- Documentation
- Không thêm Feature

---

## Minor Release

Ví dụ

1.0.0

↓

1.1.0

Áp dụng

- Feature mới
- Không Breaking Change

---

## Major Release

Ví dụ

1.0.0

↓

2.0.0

Áp dụng

- Breaking Change
- Thay đổi Architecture
- API không tương thích

---

# VERSIONING

Sử dụng

Semantic Versioning

MAJOR.MINOR.PATCH

Ví dụ

2.5.3

---

# RELEASE CANDIDATE

Release Candidate (RC)

Ví dụ

v2.0.0-rc1

v2.0.0-rc2

Mục đích

Kiểm thử cuối cùng trước Release.

---

# FEATURE FREEZE

Sau khi tạo Release Branch

Không thêm Feature mới.

Chỉ được phép

- Bug Fix
- Documentation
- Testing

---

# BUG FIX

Bug Fix trong Release

Phải

Review

↓

Test

↓

Regression Test

↓

Merge

---

# DOCUMENTATION

Trước Release

Bắt buộc cập nhật

README

CHANGELOG

API Document

Release Note

Nếu có thay đổi.

---

# CHANGELOG

Mỗi Release phải có

Version

Ngày

Feature

Bug Fix

Known Issues

Breaking Changes

Contributor

---

Ví dụ

Version

2.1.0

Feature

- Export Progress

Bug Fix

- Relative Path

Known Issues

None

---

# TESTING

Trước Release

Bắt buộc

API Test

↓

Module Test

↓

Integration Test

↓

Regression Test

↓

Performance Test (nếu có)

---

# QUALITY GATE

Release bị chặn nếu

Có Critical

Có High

Build Fail

Test Fail

Documentation thiếu

Review Fail

---

# BUILD

Build phải

- Thành công
- Không Error
- Không Warning nghiêm trọng

---

# RELEASE CHECKLIST

## Code

□ Không TODO

□ Không Debug Code

□ Không Dead Code

□ Không Duplicate Code

□ Không Hard-code mới

---

## Documentation

□ README

□ CHANGELOG

□ API

□ User Guide

---

## Testing

□ API Test

□ Module Test

□ Integration Test

□ Regression Test

□ Performance Test

---

## Review

□ Architecture

□ API

□ Batch Script

□ Documentation

---

## Git

□ Commit đầy đủ

□ Tag đúng

□ Branch sạch

□ Không Conflict

---

# GIT TAG

Ví dụ

v1.0.0

v1.1.0

v2.0.0

Không dùng

latest

new

final

---

# RELEASE PACKAGE

Ví dụ

release/

└── v2.0.0/

    ├── Source

    ├── Documentation

    ├── License

    ├── Changelog

    └── Release Note

---

# RELEASE NOTE

Bao gồm

Version

Ngày phát hành

Feature mới

Bug Fix

Known Issues

Breaking Changes

Upgrade Guide

---

# KNOWN ISSUES

Nếu còn lỗi

Phải ghi rõ

Không được che giấu.

---

# ROLLBACK

Nếu Release lỗi

Quy trình

Tag trước

↓

Rollback

↓

Hotfix

↓

Regression Test

↓

Release lại

---

# HOTFIX

Hotfix

Không thêm Feature.

Chỉ sửa lỗi.

Sau Hotfix

Phải

Regression Test.

---

# RELEASE APPROVAL

Release chỉ được thực hiện khi

Developer

↓

Reviewer

↓

Tester

↓

Release Approval

Trong dự án cá nhân

Developer tự đóng cả ba vai trò nhưng vẫn phải hoàn thành đầy đủ checklist.

---

# RELEASE CHECKLIST

Functional

□ Đúng yêu cầu

□ Không Regression

□ Không Critical

□ Không High

---

Technical

□ Build Pass

□ Test Pass

□ Review Pass

□ Documentation Pass

---

Git

□ Commit

□ Tag

□ Version

□ Changelog

---

Package

□ Source

□ Documentation

□ License

□ Release Note

---

# RED FLAGS

Critical

■ Release khi Test Fail

■ Release khi Build Fail

■ Release chưa Review

■ Release còn Critical Bug

■ Release còn High Bug

■ Không có Rollback Plan

---

High

■ Thiếu Documentation

■ Thiếu Changelog

■ Thiếu Release Note

■ Không có Git Tag

---

Medium

■ Thiếu Example

■ Thiếu Known Issues

---

Low

■ Formatting

■ Comment

---

# DEFINITION OF READY FOR RELEASE

Một phiên bản chỉ được Release khi:

✓ Build thành công

✓ API Test Pass

✓ Module Test Pass

✓ Integration Test Pass

✓ Regression Test Pass

✓ Không còn Critical

✓ Không còn High

✓ Documentation hoàn chỉnh

✓ Version cập nhật

✓ CHANGELOG cập nhật

✓ Git Tag sẵn sàng

✓ Release Package hoàn chỉnh

✓ Có thể Rollback nếu cần

---

# MỤC TIÊU CUỐI CÙNG

Mọi phiên bản phát hành của MPLAB_SOURCE_EXPORT_TOOL phải đảm bảo:

- Stable
- Tested
- Reviewed
- Traceable
- Reproducible
- Maintainable
- Documented
- Versioned
- Rollback Ready
- Release Quality