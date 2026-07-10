# API DESIGN GUIDE

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC LỤC

1. Mục tiêu
2. Thiết kế API
3. Public / Internal API
4. API Contract
5. Input Rules
6. Output Rules
7. Return Code
8. Side Effect
9. Dependency
10. Environment
11. Error Handling
12. Naming Convention
13. Documentation
14. Compatibility
15. Review Checklist

---

# 1. MỤC TIÊU

API phải:

- Dễ hiểu
- Dễ dùng
- Dễ tái sử dụng
- Dễ kiểm thử
- Dễ mở rộng
- Không gây tác dụng phụ

API là hợp đồng (Contract) giữa Caller và Module.

Một khi Public API được công bố thì phải hạn chế thay đổi hành vi.

---

# 2. THIẾT KẾ API

Mỗi API chỉ thực hiện một nhiệm vụ.

Không nên:

Scan + Export

Validate + Save

Load + Print

trong cùng một API.

Áp dụng nguyên tắc:

Single Responsibility Principle.

---

Checklist

□ Một API một nhiệm vụ

□ Tên phản ánh đúng chức năng

□ Không xử lý ngoài phạm vi

---

# 3. PUBLIC / INTERNAL API

API được chia thành:

Public API

Internal API

Private Label

---

## Public API

Được phép gọi từ module khác.

Phải có:

- Documentation
- Input
- Output
- Return Code

---

## Internal API

Chỉ module hiện tại sử dụng.

Không được gọi từ module khác.

---

## Private Label

Chỉ phục vụ nội bộ.

Có thể thay đổi bất cứ lúc nào.

---

# 4. API CONTRACT

Mỗi API phải định nghĩa rõ:

Input

↓

Output

↓

Return Code

↓

Side Effect

Caller không được phải đọc source mới biết cách sử dụng.

---

Ví dụ

Input

PROJECT_PATH

Output

RELATIVE_PATH

Return

0 = Success

1 = Invalid Parameter

2 = File Not Found

Side Effect

None

---

# 5. INPUT RULES

API phải kiểm tra:

□ NULL

□ Empty

□ Invalid

□ Relative Path

□ Absolute Path

□ Unicode

□ Space

□ Special Character

Không tin tưởng dữ liệu từ Caller.

---

# 6. OUTPUT RULES

Output phải:

Rõ ràng

Nhất quán

Có tài liệu

Không ghi đè biến ngoài ý muốn.

Không tạo Global Variable nếu không cần.

Ưu tiên:

Output Parameter

hoặc

Return Code

---

# 7. RETURN CODE

Mọi API phải trả:

0

↓

Success

Khác 0

↓

Error

Không dùng nhiều quy ước khác nhau.

Ví dụ

RC_SUCCESS = 0

RC_INVALID_PARAMETER = 1

RC_FILE_NOT_FOUND = 2

RC_ACCESS_DENIED = 3

RC_INTERNAL_ERROR = 100

---

# 8. SIDE EFFECT

API không nên:

- đổi Current Directory
- đổi PATH
- đổi Code Page
- đổi Delayed Expansion
- đổi Environment Variable
- tạo File tạm ngoài ý muốn

Nếu bắt buộc phải thay đổi thì:

- phải tài liệu hóa
- phải restore trước khi Return

---

Checklist

□ Không Side Effect

□ Restore Environment

□ Restore Current Directory

□ Restore ErrorLevel (nếu cần)

---

# 9. DEPENDENCY

API chỉ phụ thuộc:

Input Parameter

Không phụ thuộc:

Caller State

Environment

Module khác

Global Variable

Hidden Variable

---

Ví dụ tốt

call :Core_Copy "A" "B"

Ví dụ xấu

set SOURCE=A

set DEST=B

call :Core_Copy

---

Checklist

□ Không Hidden Dependency

□ Không Global State

□ Không Circular Dependency

□ Không yêu cầu Caller chuẩn bị môi trường

---

# 10. ENVIRONMENT

API phải bảo vệ môi trường thực thi.

Không làm thay đổi:

PATH

TEMP

CD

PROMPT

COMSPEC

Delayed Expansion

Extensions

Nếu thay đổi phải Restore.

---

# 11. ERROR HANDLING

API không được:

Echo lỗi rồi tiếp tục.

API phải:

Return Error Code.

Caller quyết định xử lý.

Không Exit toàn bộ chương trình.

Luôn:

EXIT /B

---

# 12. NAMING CONVENTION

Tên API phải:

Có tiền tố module.

Ví dụ

Core_Copy

Core_PathNormalize

Core_GetRelativePath

Scan_Project

Export_File

Không dùng:

Run

Do

Work

Test

ABC

Temp

---

Checklist

□ Module Prefix

□ Động từ rõ ràng

□ Không viết tắt khó hiểu

□ Không trùng tên

---

# 13. DOCUMENTATION

Mỗi Public API phải có:

Tên

Mục đích

Input

Output

Return Code

Side Effect

Ví dụ

API

Core_CopyFile

Purpose

Copy file.

Input

Source

Destination

Output

None

Return

RC_SUCCESS

RC_FILE_NOT_FOUND

Side Effect

None

---

# 14. COMPATIBILITY

Không thay đổi:

Input

Output

Return Code

của Public API nếu không cần.

Nếu thay đổi phải:

- tăng Version
- cập nhật Documentation
- thông báo Breaking Change

---

# 15. REVIEW CHECKLIST

## Contract

□ Input rõ ràng

□ Output rõ ràng

□ Return Code rõ ràng

□ Side Effect rõ ràng

---

## Dependency

□ Không Hidden Dependency

□ Không Global Variable

□ Không Circular Dependency

□ Không phụ thuộc Caller

---

## Safety

□ Restore Environment

□ Không đổi Current Directory

□ Không đổi PATH

□ Không đổi Code Page

□ Không đổi Delayed Expansion

---

## Maintainability

□ API nhỏ

□ Một nhiệm vụ

□ Documentation đầy đủ

□ Dễ kiểm thử

□ Dễ tái sử dụng

---

## Compatibility

□ Không Breaking Change

□ Return Code thống nhất

□ Naming thống nhất

□ Documentation cập nhật

---

# KẾT LUẬN

Một API được xem là đạt chuẩn khi:

✓ Chỉ thực hiện một nhiệm vụ.

✓ Không phụ thuộc Caller.

✓ Không tạo Side Effect.

✓ Có Contract rõ ràng.

✓ Có Return Code thống nhất.

✓ Có Documentation.

✓ Có thể tái sử dụng.

✓ Có thể kiểm thử độc lập.