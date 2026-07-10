# ERROR CODE STANDARD

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# Mục đích

Tài liệu này quy định cách sử dụng Return Code (RC) và ERRORLEVEL trong toàn bộ dự án.

Mục tiêu

- Chuẩn hóa Error Handling
- Dễ Debug
- Dễ Maintain
- API nhất quán
- Không mất ERRORLEVEL ngoài ý muốn

---

# Nguyên tắc

Mọi API phải trả về trạng thái bằng

ERRORLEVEL

Không dùng chuỗi

SUCCESS

FAILED

TRUE

FALSE

để thay thế Return Code.

---

# Return Convention

API

↓

exit /b RC_xxx

Caller

↓

if errorlevel ...

Không dùng biến Global để báo lỗi.

---

# Chuẩn Return

RC_SUCCESS = 0

Mọi giá trị khác 0

Đều là lỗi.

---

# Không Reset ERRORLEVEL

Không được vô tình ghi đè ERRORLEVEL.

Ví dụ

Sai

echo Done

exit /b

Có thể làm mất ErrorLevel.

---

Đúng

exit /b %RC_SUCCESS%

---

# Caller Rule

Caller luôn kiểm tra Return Code.

Ví dụ

call Core.NormalizePath ...

if errorlevel 1 (

    ...

)

Không bỏ qua ErrorLevel.

---

# API Rule

Một API

Một Return Code.

Không trả nhiều kiểu.

Ví dụ

Sai

echo ERROR

exit /b 1

---

Đúng

exit /b %RC_INVALID_PATH%

---

# RC Naming

Tất cả Return Code

Đều bắt đầu bằng

RC_

Ví dụ

RC_SUCCESS

RC_FAILED

RC_INVALID_PARAMETER

RC_FILE_NOT_FOUND

RC_PATH_NOT_FOUND

---

# Error Category

## Success

RC_SUCCESS

---

## Parameter

RC_INVALID_PARAMETER

RC_NULL_PARAMETER

RC_EMPTY_STRING

RC_INVALID_INDEX

RC_OUT_OF_RANGE

---

## File

RC_FILE_NOT_FOUND

RC_FILE_ALREADY_EXISTS

RC_FILE_READ_ERROR

RC_FILE_WRITE_ERROR

RC_FILE_DELETE_ERROR

RC_FILE_COPY_ERROR

RC_FILE_MOVE_ERROR

---

## Folder

RC_DIRECTORY_NOT_FOUND

RC_DIRECTORY_ALREADY_EXISTS

RC_DIRECTORY_CREATE_ERROR

RC_DIRECTORY_DELETE_ERROR

---

## Path

RC_INVALID_PATH

RC_RELATIVE_PATH_REQUIRED

RC_ABSOLUTE_PATH_REQUIRED

RC_PATH_TOO_LONG

---

## Scan

RC_SCAN_FAILED

RC_SCAN_CANCELLED

RC_SCAN_EMPTY

RC_SCAN_TIMEOUT

---

## Export

RC_EXPORT_FAILED

RC_EXPORT_CANCELLED

RC_EXPORT_EMPTY

---

## Search

RC_SEARCH_FAILED

RC_SEARCH_EMPTY

RC_SEARCH_TIMEOUT

---

## Configuration

RC_CONFIGURATION_ERROR

RC_CONFIGURATION_MISSING

RC_CONFIGURATION_INVALID

---

## Environment

RC_ENVIRONMENT_ERROR

RC_DELAYEDEXPANSION_REQUIRED

RC_CODEPAGE_ERROR

RC_PERMISSION_DENIED

---

## Internal

RC_INTERNAL_ERROR

RC_NOT_IMPLEMENTED

RC_UNEXPECTED_STATE

---

# Numeric Range

Đề nghị

0

Success

1~49

General

50~99

Parameter

100~149

Path

150~199

File

200~249

Directory

250~299

Search

300~349

Scan

350~399

Export

400~449

Configuration

450~499

Environment

500+

Internal

---

# Return Flow

API

↓

Validate

↓

Business Logic

↓

Cleanup

↓

exit /b RC_xxx

Không Return giữa chừng nếu chưa Cleanup.

---

# Cleanup

Trước khi Return

Phải

Restore Environment

Release Resource

Delete Temporary Data

Sau đó mới

exit /b

---

# Propagation

Nếu Callee lỗi

Caller phải quyết định.

Ví dụ

call Core.CopyFile ...

if errorlevel 1 (

    exit /b %ERRORLEVEL%

)

Không đổi mã lỗi nếu không cần.

---

# Error Translation

Chỉ dịch Error Code khi thật sự cần.

Ví dụ

Core

↓

RC_FILE_NOT_FOUND

Scan

↓

RC_SCAN_FAILED

Chỉ khi Business Logic yêu cầu.

---

# Logging

Không Log trong Core Utility.

Business Layer quyết định.

Ví dụ

Core

↓

Return RC

Scan

↓

Write Log

↓

Return RC

---

# Retry

Không Retry trong Utility.

Retry thuộc Business Layer.

---

# Fatal Error

Không API nào được

exit

Toàn chương trình.

Chỉ

exit /b

Main quyết định kết thúc.

---

# Message

Không gắn Message cứng trong API.

Sai

echo File not found.

exit /b

---

Đúng

exit /b %RC_FILE_NOT_FOUND%

Caller hiển thị Message.

---

# Output

API chỉ trả

Return Code

và

Output Data.

Không trả Message.

---

# ERRORLEVEL

Sau khi gọi API

Không được chạy thêm lệnh

trước khi kiểm tra ErrorLevel.

Sai

call ...

echo Done

if errorlevel 1 ...

---

Đúng

call ...

if errorlevel 1 ...

---

# Error Handling Pattern

call API

↓

Check RC

↓

Cleanup

↓

Report

↓

Continue / Exit

---

# Checklist

## Return

□ Luôn dùng exit /b

□ Không exit toàn chương trình

□ Chỉ một Return Code

□ Không dùng String báo lỗi

---

## Caller

□ Luôn kiểm tra ERRORLEVEL

□ Không bỏ qua Return Code

□ Không ghi đè ERRORLEVEL

□ Có Propagate khi cần

---

## API

□ Cleanup trước Return

□ Không Log

□ Không Message

□ Không Side Effect

---

## Naming

□ RC_ prefix

□ Tên rõ nghĩa

□ Không trùng

□ Theo Category

---

## Maintainability

□ Error Code có tài liệu

□ Không Hard-code số

□ Dùng Constant

□ Có Comment khi cần

---

# Red Flags

Đánh dấu Critical nếu phát hiện

■ API exit toàn chương trình

■ Không dùng exit /b

■ Mất ERRORLEVEL

■ Hard-code số lỗi

■ Không kiểm tra Return Code

■ Ghi đè ERRORLEVEL

■ Trả nhiều kiểu lỗi

■ API vừa Log vừa Return

■ API vừa Message vừa Return

---

# Ví dụ

Đúng

call "%~dp001_Core.bat" Core.NormalizePath "%INPUT%"

if errorlevel 1 (

    exit /b %ERRORLEVEL%

)

Sai

call "%~dp001_Core.bat" Core.NormalizePath "%INPUT%"

echo Done

if errorlevel 1 (

)

---

# Mục tiêu cuối cùng

Toàn bộ MPLAB_SOURCE_EXPORT_TOOL phải đạt

- Return Code thống nhất
- API nhất quán
- Không mất ERRORLEVEL
- Không Hard-code số lỗi
- Không Exit ngoài ý muốn
- Caller luôn kiểm tra lỗi
- Cleanup trước Return
- Error Propagation rõ ràng
- Dễ Debug
- Dễ Test
- Dễ Maintain