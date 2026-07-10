# GIT WORKFLOW

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC ĐÍCH

Tài liệu này quy định quy trình làm việc với Git trong toàn bộ dự án.

Mục tiêu

- Lịch sử Git rõ ràng
- Dễ Review
- Dễ Rollback
- Dễ Release
- Hạn chế Merge Conflict

---

# NGUYÊN TẮC

Git là công cụ quản lý lịch sử.

Không dùng Git như nơi lưu file tạm.

Mọi Commit phải:

- Có mục đích rõ ràng
- Có thể Build
- Có thể Review

---

# BRANCH MODEL

Các Branch chính

main

↓

develop

↓

feature/*

↓

hotfix/*

↓

release/*

---

## main

Branch ổn định.

Chỉ chứa:

- Phiên bản Release
- Đã Test
- Đã Review

Không Commit trực tiếp.

---

## develop

Branch phát triển.

Sau khi hoàn thành Feature

↓

Merge vào develop

---

## feature

Ví dụ

feature/export-progress

feature/api-normalize-path

feature/core-copy-file

Mỗi Branch

Một tính năng.

---

## hotfix

Ví dụ

hotfix/path-bug

hotfix/errorlevel

hotfix/unicode

Chỉ sửa lỗi.

Không thêm Feature.

---

## release

Ví dụ

release/v1.2.0

Chỉ dùng chuẩn bị Release.

Không phát triển tính năng mới.

---

# BRANCH NAMING

Đúng

feature/core-relative-path

feature/menu-progress

hotfix/file-not-found

release/v2.0

Sai

test

abc

new

fix

branch1

---

# COMMIT RULE

Một Commit

↓

Một mục đích.

Không Commit nhiều Feature.

---

Ví dụ

Đúng

Refactor Core.NormalizePath

Sai

Fix bug

Update

Modify

Code

....

---

# COMMIT MESSAGE

Format

TYPE: Summary

Ví dụ

feat: add export statistics

fix: resolve relative path bug

refactor: simplify Core.CopyFile

docs: update API guide

test: add NormalizePath test

style: format comments

---

# COMMIT TYPE

feat

Thêm Feature

---

fix

Sửa Bug

---

refactor

Refactor

---

docs

Documentation

---

test

Test

---

style

Formatting

---

chore

Maintenance

---

build

Build

---

release

Release

---

# COMMIT SIZE

Một Commit

Khuyến nghị

<300 dòng thay đổi.

Không Commit

2000 dòng

Nếu có thể chia nhỏ.

---

# BEFORE COMMIT

□ Build thành công

□ Test Pass

□ Không Debug Code

□ Không TODO

□ Không File tạm

□ Không Comment thừa

□ Documentation cập nhật

□ Review xong

---

# PULL REQUEST

PR phải có

Tiêu đề

↓

Mô tả

↓

Lý do

↓

Ảnh hưởng

↓

Testing

↓

Checklist

---

Ví dụ

Title

Fix Relative Path API

Description

API không còn phụ thuộc Delayed Expansion.

Testing

API Test

Regression Test

---

# CODE REVIEW

Trước Merge

Phải Review

Architecture

↓

API

↓

Batch Script

↓

Testing

↓

Documentation

---

# MERGE RULE

Không Merge nếu

Có Critical Bug

Có High Bug

Build Fail

Test Fail

Review Fail

---

# REBASE

Khuyến nghị

Rebase

trước Merge

để lịch sử sạch.

---

# TAG

Release

Sử dụng

v1.0.0

v1.1.0

v2.0.0

Không dùng

new

latest

final

---

# VERSION

Semantic Versioning

MAJOR.MINOR.PATCH

Ví dụ

1.0.0

↓

1.0.1

↓

1.1.0

↓

2.0.0

---

## PATCH

Bug Fix

---

## MINOR

Feature mới

Không Breaking Change.

---

## MAJOR

Breaking Change.

---

# RELEASE PROCESS

Feature

↓

Review

↓

Testing

↓

Merge develop

↓

Release Branch

↓

Regression Test

↓

Tag

↓

Merge main

---

# HOTFIX PROCESS

main

↓

hotfix

↓

Review

↓

Test

↓

Merge main

↓

Merge develop

---

# FILE RULE

Không Commit

*.tmp

*.bak

*.log

*.cache

*.obj

*.exe

*.zip

---

# .gitignore

Bắt buộc có

.gitignore

Không Commit

Temporary File

Build Output

Editor Cache

---

# DOCUMENTATION

Mọi Feature mới

↓

Documentation

↓

Commit

↓

Merge

---

# TEST

Mọi Bug Fix

↓

Regression Test

↓

Commit

---

# ROLLBACK

Nếu Commit lỗi

Không Rewrite History trên main.

Ưu tiên

git revert

Chỉ dùng

git reset

khi Branch chưa chia sẻ.

---

# CHECKLIST

## Branch

□ Đúng tên

□ Một mục đích

---

## Commit

□ Commit nhỏ

□ Có Message rõ

□ Build Pass

□ Test Pass

---

## Review

□ Architecture

□ API

□ Batch

□ Documentation

---

## Merge

□ Không Conflict

□ Không Critical

□ Không High

□ Review Pass

---

## Release

□ Version cập nhật

□ Tag

□ Changelog

□ Documentation

---

# RED FLAGS

Critical

■ Commit trực tiếp lên main

■ Merge khi Test Fail

■ Merge khi Build Fail

■ Force Push lên main

■ Rewrite History trên Release

High

■ Commit nhiều Feature

■ Không Review

■ Không Test

■ Không Documentation

■ Commit Debug Code

Medium

■ Commit quá lớn

■ Message không rõ

■ Thiếu Changelog

Low

■ Formatting

■ Comment

---

# DEFINITION OF READY FOR MERGE

Một Branch chỉ được Merge khi:

✓ Build thành công.

✓ API Test Pass.

✓ Module Test Pass.

✓ Integration Test Pass.

✓ Regression Test Pass.

✓ Không còn Critical.

✓ Không còn High.

✓ Documentation cập nhật.

✓ Review hoàn tất.

✓ Có thể Release.

---

# MỤC TIÊU CUỐI CÙNG

Git Workflow của MPLAB_SOURCE_EXPORT_TOOL phải đảm bảo:

- Lịch sử Commit rõ ràng
- Dễ Review
- Dễ Rollback
- Dễ Release
- Dễ Trace Bug
- Dễ mở rộng cho nhiều lập trình viên
- Hạn chế Merge Conflict
- Hạn chế Regression