# CONFIGURATION GUIDE

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# Mục đích

Tài liệu này quy định cách khai báo, quản lý và sử dụng Configuration trong toàn bộ dự án.

Mục tiêu

- Cấu hình tập trung
- Dễ bảo trì
- Dễ mở rộng
- Không Hard-code
- Không trùng lặp
- Không làm bẩn Environment

---

# Nguyên tắc

Configuration phải

- Rõ ràng
- Có Owner
- Có tài liệu
- Không thay đổi trong Runtime (trừ khi được thiết kế)

---

# Configuration Layer

Thứ tự ưu tiên

Application Default

↓

User Configuration

↓

Runtime Configuration

↓

Temporary Configuration

Không được đảo ngược.

---

# Phân loại Configuration

## Application Configuration

Ví dụ

APP_NAME

APP_VERSION

APP_AUTHOR

APP_LICENSE

APP_BUILD

APP_COPYRIGHT

Được xem là Read-only.

---

## Project Configuration

Ví dụ

PROJECT_PATH

MODULE_PATH

DOC_PATH

RELEASE_PATH

EXAMPLE_PATH

---

## Runtime Configuration

Ví dụ

CURRENT_FILE

CURRENT_FOLDER

CURRENT_PROGRESS

SCAN_TOTAL

Được phép thay đổi.

---

## Temporary Configuration

Ví dụ

TMP_PATH

TMP_FILE

BUFFER

CACHE

Chỉ tồn tại trong thời gian ngắn.

---

# Naming Rule

Configuration

Luôn viết HOA.

Ví dụ

PROJECT_PATH

APP_VERSION

OUTPUT_DIRECTORY

Không dùng

ProjectPath

projectPath

project_path

---

# Prefix Rule

Ứng dụng

APP_

Ví dụ

APP_NAME

APP_VERSION

---

Dự án

PROJECT_

Ví dụ

PROJECT_PATH

PROJECT_ROOT

---

Module

MODULE_

Ví dụ

MODULE_PATH

MODULE_NAME

---

Runtime

CURRENT_

Ví dụ

CURRENT_FILE

CURRENT_INDEX

---

Temporary

TMP_

Ví dụ

TMP_FILE

TMP_PATH

---

# Khai báo

Tất cả Configuration

Phải tập trung.

Ví dụ

01_Core.bat

hoặc

11_Configuration.bat

Không khai báo rải rác.

---

# Read-only Configuration

Ví dụ

APP_NAME

APP_VERSION

PROJECT_ROOT

Không được sửa sau khi khởi tạo.

---

# Mutable Configuration

Ví dụ

CURRENT_FILE

CURRENT_INDEX

PROGRESS

Cho phép thay đổi.

---

# Hard-code

Không Hard-code

Ví dụ

Sai

set OUTPUT=C:\Export

---

Đúng

set OUTPUT=%EXPORT_PATH%

---

# Path

Path phải Normalize.

Ví dụ

C:\Project\

↓

C:\Project

---

# Relative Path

Ưu tiên

Relative Path

Trong Project.

Ví dụ

docs

modules

release

Không Hard-code

C:\Users\...

---

# Absolute Path

Chỉ dùng

Khi thật sự cần.

---

# Environment

Không ghi vào

PATH

TEMP

COMSPEC

Nếu không Restore.

---

# Runtime Update

Configuration Runtime

Phải có Owner.

Ví dụ

CURRENT_FILE

Owner

Scan Module

Không module khác được sửa.

---

# Validation

Configuration phải được kiểm tra.

Ví dụ

PROJECT_PATH

↓

Folder Exists

↓

Accessible

↓

Normalize

↓

Use

---

# Default Value

Configuration

Phải có Default.

Ví dụ

BAR_WIDTH=60

Không để Undefined.

---

# Undefined

Trước khi dùng

Phải kiểm tra.

Ví dụ

if not defined PROJECT_PATH

Không sử dụng trực tiếp.

---

# Empty String

Phải phân biệt

Undefined

và

Empty.

Ví dụ

set VALUE=

khác

VALUE chưa tồn tại.

---

# Boolean

Quy ước

1

0

Không dùng

YES

NO

TRUE

FALSE

Lẫn lộn.

---

# Number

Luôn Validate.

Ví dụ

BAR_WIDTH

↓

Integer

↓

Positive

↓

Trong giới hạn.

---

# String

Nên

Trim

Normalize

Escape

Trước khi sử dụng.

---

# File Configuration

Ví dụ

LOG_FILE

REPORT_FILE

OUTPUT_FILE

Phải Normalize Path.

---

# Folder Configuration

Ví dụ

DOC_PATH

MODULE_PATH

OUTPUT_PATH

Kiểm tra tồn tại trước.

---

# Configuration API

Mọi thao tác Configuration

Nên thông qua API.

Ví dụ

Config.Get

Config.Set

Config.Exists

Config.Validate

Không truy cập trực tiếp nếu có API.

---

# Side Effect

API Configuration

Không được

Đổi Current Directory

Đổi Code Page

Đổi PATH

Không Restore.

---

# Logging

Không Log

Thông tin nhạy cảm.

Ví dụ

API Key

Password

Token

---

# Documentation

Mỗi Configuration

Phải có

Tên

Ý nghĩa

Kiểu dữ liệu

Default

Owner

Ví dụ

PROJECT_PATH

Type

Path

Default

Project Root

Owner

Bootstrap

---

# Configuration Table

Ví dụ

| Name | Type | Default | Owner | Mutable |
|------|------|---------|--------|---------|
| APP_NAME | String | MPLAB SOURCE EXPORT TOOL | Core | No |
| PROJECT_PATH | Path | Project Root | Bootstrap | No |
| CURRENT_FILE | Path | Empty | Scan | Yes |
| BAR_WIDTH | Integer | 60 | UI | Yes |

---

# Checklist

## Naming

□ Dùng chữ HOA

□ Có Prefix

□ Không viết tắt khó hiểu

□ Không trùng tên

---

## Value

□ Có Default

□ Validate

□ Normalize

□ Không Hard-code

---

## Runtime

□ Có Owner

□ Không sửa Read-only

□ Không dùng Global không cần thiết

□ Scope phù hợp

---

## Environment

□ Không làm bẩn Environment

□ Có Restore

□ Không sửa PATH

□ Không đổi Code Page

---

## Documentation

□ Có mô tả

□ Có Default

□ Có Owner

□ Có kiểu dữ liệu

---

# Red Flags

Critical

■ Hard-code Path

■ Không Validate Configuration

■ Không có Default

■ Sửa Read-only Configuration

■ Ghi đè Environment

■ Configuration không có Owner

■ Dùng Global Variable sai mục đích

■ Không Normalize Path

■ Thiếu kiểm tra Undefined

■ Thiếu kiểm tra Empty String

---

# Mục tiêu cuối cùng

Hệ thống Configuration của MPLAB_SOURCE_EXPORT_TOOL phải đạt

- Tập trung
- Có Owner
- Có Default
- Có Validation
- Có Documentation
- Không Hard-code
- Không Environment Pollution
- Dễ mở rộng
- Dễ bảo trì
- Dễ kiểm thử
- Dễ Refactor