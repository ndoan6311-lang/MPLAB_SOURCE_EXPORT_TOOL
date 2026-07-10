# BATCH SCRIPT STANDARD

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC TIÊU

Tiêu chuẩn này áp dụng cho tất cả module Batch Script trong dự án.

Mục tiêu:

- Đúng
- An toàn
- Có thể tái sử dụng
- Có thể mở rộng
- Dễ bảo trì

Không chỉ hoạt động.

Mà phải hoạt động ổn định trong môi trường lớn.

---

# 1. MODULE DESIGN

Một module chỉ nên có một trách nhiệm.

Không được:

- vừa Scan
- vừa Export
- vừa Logging

trong cùng một API.

Module phải độc lập.

---

Checklist

□ Single Responsibility

□ Không phụ thuộc vòng

□ Không phụ thuộc Current Directory

□ Không tự thay đổi môi trường caller

□ Không yêu cầu caller chuẩn bị trước nếu không được tài liệu hóa

---

# 2. API DESIGN

API phải có:

Input

↓

Process

↓

Output

↓

Return Code

Không được:

- sửa biến ngoài ý muốn
- thay đổi thư mục làm việc
- thay đổi Code Page
- thay đổi PATH

---

Checklist

□ Input rõ ràng

□ Output rõ ràng

□ Return Code rõ ràng

□ Không có Hidden Dependency

□ Không Side Effect

□ Có thể gọi nhiều lần

□ Có thể tái sử dụng

---

# 3. VARIABLE

Không dùng Global Variable nếu không cần.

Ưu tiên:

SETLOCAL

↓

Local Variable

↓

ENDLOCAL

---

Checklist

□ Không ghi đè biến hệ thống

□ Không đổi PATH

□ Không đổi TEMP

□ Không đổi COMSPEC

□ Không đổi CD

□ Biến đặt tên rõ nghĩa

□ Không dùng tên quá ngắn

□ Không để rò rỉ biến

---

# 4. DELAYED EXPANSION

Không yêu cầu caller EnableDelayedExpansion.

Module phải tự quản lý.

Nếu cần phải:

SETLOCAL EnableDelayedExpansion

ENDLOCAL

---

Checklist

□ Không phụ thuộc caller

□ Không làm hỏng dữ liệu chứa !

□ Không dùng ! khi không cần

□ Có restore trạng thái

---

# 5. ERROR HANDLING

Không dùng EXIT trực tiếp.

Luôn:

EXIT /B

API phải trả Return Code.

Không echo lỗi rồi tiếp tục.

---

Checklist

□ Có Return Code

□ Không mất ErrorLevel

□ Không nuốt lỗi

□ Có xử lý lỗi File

□ Có xử lý lỗi Folder

□ Có xử lý lỗi Permission

---

# 6. RETURN CONVENTION

Mọi API đều phải trả:

0

↓

Success

Khác 0

↓

Error

Không dùng nhiều kiểu khác nhau.

---

Checklist

□ Return Code thống nhất

□ Có hằng số RC_SUCCESS

□ Có RC_INVALID_PARAMETER

□ Có RC_FILE_NOT_FOUND

□ Có RC_ACCESS_DENIED

---

# 7. PATH HANDLING

Không Hard-code.

Không nối chuỗi bằng tay.

Ưu tiên API xử lý Path.

---

Checklist

□ Relative Path

□ Absolute Path

□ UNC Path

□ Space

□ Unicode

□ Dấu ()

□ Dấu []

□ Dấu !

□ Dấu ^

□ Dấu %

□ Dấu &

□ Dấu |

---

# 8. STRING HANDLING

Không dùng Replace nếu chưa kiểm tra.

Không assume Encoding.

---

Checklist

□ Empty String

□ NULL

□ Unicode

□ Space

□ Escape

□ Trim

□ Case Sensitive

---

# 9. LOOP

Không scan nhiều lần cùng dữ liệu.

Không lặp vô hạn.

---

Checklist

□ Không Loop dư

□ Không CALL trong Loop nếu tránh được

□ Không EnableDelayedExpansion nếu không cần

---

# 10. FILE I/O

Mọi thao tác File phải kiểm tra.

---

Checklist

□ File tồn tại

□ Folder tồn tại

□ Quyền ghi

□ Quyền đọc

□ Locked File

□ Read Only

---

# 11. PERFORMANCE

Không tối ưu sớm.

Nhưng tránh:

CALL trong loop

SET nhiều lần

FOR lồng nhau

DIR lặp

---

Checklist

□ Không scan dư

□ Không copy dư

□ Không tạo file tạm dư

---

# 12. DEPENDENCY

Module chỉ phụ thuộc API công khai.

Không gọi Label nội bộ.

---

Checklist

□ Không Circular Dependency

□ Không Hidden Dependency

□ API độc lập

---

# 13. REUSABILITY

API phải dùng lại được.

Không Hard-code.

Không phụ thuộc project.

---

Checklist

□ Reusable

□ Parameterized

□ Generic

---

# 14. SECURITY

Không Execute dữ liệu người dùng trực tiếp.

Luôn Quote.

---

Checklist

□ Quote đầy đủ

□ Escape đầy đủ

□ Không Command Injection

---

# 15. DOCUMENTATION

Mỗi API cần mô tả:

- Input
- Output
- Return Code
- Side Effect

---

# BÁO CÁO REVIEW

## Module

...

---

## API

...

---

## Delayed Expansion

...

---

## Variable

...

---

## Error Handling

...

---

## Path Handling

...

---

## Performance

...

---

## Security

...

---

## Kết luận

Critical

High

Medium

Low