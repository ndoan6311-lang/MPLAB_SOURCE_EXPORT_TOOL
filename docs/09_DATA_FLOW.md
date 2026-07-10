# DATA FLOW GUIDE

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# Mục đích

Tài liệu này quy định cách dữ liệu được tạo, truyền, xử lý và trả về giữa các module.

Mục tiêu:

- Luồng dữ liệu rõ ràng
- Không truyền dữ liệu ngầm
- Hạn chế Global Variable
- Giảm Side Effect
- Dễ Debug
- Dễ Test
- Dễ Refactor

---

# Nguyên tắc

Dữ liệu chỉ đi theo một chiều.

Input

↓

Validate

↓

Normalize

↓

Business Logic

↓

Output

Không được xử lý ngược.

---

# Data Owner

Mỗi dữ liệu phải có đúng một nơi sở hữu.

Ví dụ

PROJECT_PATH

Owner

Bootstrap

---

SCAN_RESULT

Owner

Scan

---

EXPORT_PATH

Owner

Export

Không có nhiều module cùng sửa một dữ liệu.

---

# Data Lifetime

Phân loại dữ liệu

## Configuration

Ví dụ

APP_NAME

VERSION

PROJECT_PATH

Được phép tồn tại toàn chương trình.

---

## Runtime

Ví dụ

CURRENT_FILE

CURRENT_INDEX

MATCH_COUNT

Chỉ tồn tại trong lúc xử lý.

Không lưu lại sau khi API kết thúc.

---

## Temporary

Ví dụ

TMP

BUFFER

LINE

INDEX

Chỉ dùng trong nội bộ API.

---

# Input

API chỉ nhận dữ liệu qua Parameter.

Ví dụ

call Core.NormalizePath "%INPUT%"

Đúng.

---

Sai

set INPUT=...

call Core.NormalizePath

---

# Validate

Ngay sau khi nhận dữ liệu phải kiểm tra.

Ví dụ

Empty String

NULL

Relative Path

Absolute Path

Illegal Character

File Exists

Folder Exists

Không xử lý nếu dữ liệu chưa hợp lệ.

---

# Normalize

Sau Validate phải Normalize.

Ví dụ

Path

Tên File

Extension

Slash

Case

Ví dụ

abc\..\test.txt

↓

C:\Project\test.txt

---

# Business Logic

Sau Normalize mới xử lý.

Không xử lý trực tiếp dữ liệu thô.

---

# Output

Output phải rõ ràng.

Một API chỉ nên có một Output chính.

Ví dụ

Return Code

Output Variable

Hoặc

Stdout

Không dùng nhiều cách cùng lúc.

---

# Data Passing

Ưu tiên

Parameter

↓

Output Variable

↓

Temporary File

↓

Global Variable

Global Variable là lựa chọn cuối cùng.

---

# Global Variable

Chỉ dùng cho

Application Configuration

Ví dụ

APP_NAME

APP_VERSION

PROJECT_PATH

BUILD_DATE

---

Không dùng

CURRENT_FILE

MATCH_RESULT

ERROR_MESSAGE

INDEX

COUNT

---

# Environment Variable

API không được làm bẩn Environment.

Ví dụ

Sai

set FILE=...

set INDEX=...

Không Restore

---

Đúng

set LOCAL_FILE=...

ENDLOCAL

---

# Variable Scope

Biến phải có phạm vi nhỏ nhất.

Ví dụ

FOR

↓

IF

↓

API

↓

Module

↓

Application

---

# Data Ownership

Một biến chỉ có một nơi ghi.

Có nhiều nơi đọc.

Ví dụ

MATCH_COUNT

Scan ghi

Statistics đọc

Không được

Scan ghi

Export sửa

Cleanup sửa

---

# Immutable Data

Configuration nên xem như Read-only.

Ví dụ

PROJECT_PATH

Không sửa trong Runtime.

---

# Mutable Data

Các biến Runtime được phép thay đổi.

Ví dụ

INDEX

CURRENT_FILE

CURRENT_PROGRESS

---

# Shared Data

Nếu nhiều module cần dùng

Ưu tiên truyền Parameter.

Không chia sẻ Global Variable.

---

# Temporary File

Chỉ tạo khi thật sự cần.

Sau khi dùng

Phải xóa.

---

# Cache

Nếu tạo Cache

Phải có

Owner

Lifetime

Cleanup

---

# Error Data

Thông báo lỗi

Không ghi vào Global Variable.

Trả về bằng

ErrorLevel

hoặc

Output Variable.

---

# Data Consistency

Nếu một API thay đổi dữ liệu

Phải đảm bảo

Atomic.

Không để trạng thái nửa chừng.

---

# Side Effect

API không được

Đổi Current Directory

Đổi Code Page

Đổi PATH

Đổi Environment

Nếu có

Phải Restore.

---

# Logging

Không ghi Log bên trong Utility API.

Chỉ Business Layer ghi Log.

---

# File Processing

Một file

↓

Read

↓

Validate

↓

Normalize

↓

Process

↓

Output

↓

Close

Không xử lý khi chưa Close File.

---

# Path Flow

Raw Path

↓

Normalize

↓

Validate

↓

Absolute Path

↓

Business Logic

---

# String Flow

Input

↓

Trim

↓

Validate

↓

Escape

↓

Process

---

# Array Flow

Read

↓

Count

↓

Validate Index

↓

Process

↓

Return

---

# Error Flow

API

↓

Return RC_xxx

↓

Caller quyết định xử lý.

Không tự Exit toàn chương trình.

---

# Dependency

Module chỉ truyền dữ liệu cho

Caller

hoặc

Callee trực tiếp.

Không truyền vòng nhiều tầng.

---

# Data Security

Không Log

Password

API Key

Token

Credential

Nếu có

Mask trước.

---

# Checklist

## Input

□ Nhận dữ liệu qua Parameter

□ Không dùng Global Variable

□ Validate đầy đủ

□ Normalize trước khi xử lý

---

## Output

□ Output rõ ràng

□ Return Code chính xác

□ Không ghi dữ liệu ngoài ý muốn

---

## Variable

□ Scope nhỏ nhất

□ Không rò rỉ biến

□ Không ghi đè Configuration

□ Không dùng biến toàn cục nếu không cần

---

## Side Effect

□ Không đổi Current Directory

□ Không đổi Code Page

□ Không đổi PATH

□ Không đổi Environment

□ Có Restore nếu thay đổi

---

## Lifetime

□ Temporary được xóa

□ Cache được Cleanup

□ File được Close

□ Resource được Release

---

## Maintainability

□ Luồng dữ liệu rõ ràng

□ Có Data Owner

□ Không truyền dữ liệu ngầm

□ Không copy dữ liệu dư thừa

---

# Red Flags

Đánh dấu Critical hoặc High nếu phát hiện

■ Truyền dữ liệu bằng Global Variable

■ API phụ thuộc trạng thái trước đó

■ Không Validate Input

■ Không Normalize

■ Side Effect không Restore

■ Ghi dữ liệu ngoài phạm vi

■ Có nhiều Owner cho cùng một biến

■ Dữ liệu Runtime tồn tại quá lâu

■ Thay đổi Configuration trong Runtime

■ API tự ý Exit chương trình

---

# Mục tiêu cuối cùng

Luồng dữ liệu của MPLAB_SOURCE_EXPORT_TOOL phải đạt:

- Một chiều
- Rõ ràng
- Có Data Owner
- Không Side Effect
- Không Environment Pollution
- Không Global State không cần thiết
- Validate đầy đủ
- Normalize trước xử lý
- Output nhất quán
- Dễ Debug
- Dễ Test
- Dễ Refactor
- Dễ mở rộng