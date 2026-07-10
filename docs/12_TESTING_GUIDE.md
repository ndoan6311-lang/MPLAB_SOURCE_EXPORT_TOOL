# TESTING GUIDE

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# 1. MỤC TIÊU

Đảm bảo:

- Đúng chức năng
- Không phát sinh bug mới
- Không làm thay đổi hành vi cũ
- Có thể mở rộng an toàn
- Có thể refactor an toàn

Testing phải được thực hiện sau mỗi thay đổi.

---

# 2. TESTING PYRAMID

Ưu tiên:

API Test

↓

Module Test

↓

Integration Test

↓

End-to-End Test

Không chỉ chạy toàn bộ chương trình.

API phải được kiểm thử độc lập.

---

# 3. TEST LEVEL

## Level 1

API Test

Kiểm tra từng API riêng.

Ví dụ

Core.NormalizePath

Core.StringContains

Core.FileExists

...

---

## Level 2

Module Test

Kiểm tra:

01_Core.bat

02_Scan.bat

03_Menu.bat

...

---

## Level 3

Integration Test

Kiểm tra nhiều module cùng hoạt động.

Ví dụ

Scan

↓

Export

↓

Statistics

---

## Level 4

Regression Test

Sau mỗi lần sửa.

Phải chạy lại:

Toàn bộ test cũ.

---

# 4. API TEST

Mỗi API phải có:

Input

Expected Output

Expected ErrorLevel

Environment

---

Ví dụ

Input

abc.txt

Output

abc.txt

RC_SUCCESS

---

Input

"" (Empty)

Output

Error

RC_INVALID_PARAMETER

---

# 5. TEST INPUT

Luôn kiểm tra:

Normal

Boundary

Invalid

Unexpected

---

Ví dụ

Normal

abc.txt

Boundary

255 ký tự

Invalid

???

Unexpected

Unicode

---

# 6. STRING TEST

Kiểm tra:

Empty

NULL

Space

Tab

Unicode

UTF-8

Special Character

Very Long String

---

Ví dụ

""

" "

"abc"

"á"

"!%^&"

---

# 7. PATH TEST

Kiểm tra

Relative

Absolute

UNC

Drive Root

Current Directory

Parent Directory

Long Path

Unicode

Hidden File

Read Only

---

Ví dụ

.

..

C:\

D:\

\\Server

..\File

---

# 8. FILE TEST

Kiểm tra

Không tồn tại

Có tồn tại

Read Only

Hidden

System

Zero Byte

Large File

Locked File

---

# 9. DIRECTORY TEST

Kiểm tra

Empty

Nested

Read Only

Hidden

Unicode

Long Path

---

# 10. VARIABLE TEST

Kiểm tra

Undefined

Empty

Normal

Special Character

Unicode

Very Long

---

# 11. ERRORLEVEL TEST

Kiểm tra

RC_SUCCESS

RC_WARNING

RC_ERROR

RC_INVALID_PARAMETER

RC_FILE_NOT_FOUND

...

Sau khi API kết thúc

ErrorLevel phải đúng.

---

# 12. DELAYED EXPANSION TEST

Kiểm tra

Enable

Disable

Nested

Dynamic Variable

Special Character

!

%

^

&

|

(

)

---

# 13. QUOTING TEST

Kiểm tra

Có dấu cách

Có ngoặc

Có dấu "

Unicode

Ký tự đặc biệt

---

# 14. PERFORMANCE TEST

Đo

Execution Time

Memory

Disk Access

Loop Count

File Count

---

Không benchmark bằng cảm tính.

---

# 15. STRESS TEST

Kiểm tra

100 file

1000 file

10000 file

Nhiều thư mục

Đường dẫn dài

---

# 16. INTEGRATION TEST

Ví dụ

Main

↓

Scan

↓

Export

↓

Cleanup

↓

Statistics

Kiểm tra:

Data truyền đúng.

Không mất ErrorLevel.

---

# 17. REGRESSION TEST

Sau mỗi lần sửa.

Chạy lại

API Test

↓

Module Test

↓

Integration Test

---

Không bỏ qua Regression.

---

# 18. NEGATIVE TEST

Luôn kiểm tra

Sai tham số

Thiếu tham số

Sai kiểu dữ liệu

Sai Path

Sai Encoding

Sai Module

---

# 19. ENVIRONMENT TEST

Trước khi gọi API

Lưu

Current Directory

Environment Variable

Code Page

Delayed Expansion

ErrorLevel

Sau khi API

Kiểm tra

Có bị thay đổi không.

---

# 20. SIDE EFFECT TEST

API không được

Tự đổi thư mục

Tự đổi PATH

Tự đổi Code Page

Tự set biến Global

Nếu có

Phải ghi rõ.

---

# 21. OUTPUT TEST

Kiểm tra

Console

Log

Export

Generated File

Encoding

Line Ending

---

# 22. LOG TEST

Kiểm tra

Đầy đủ

Đúng thứ tự

Không mất dữ liệu

Không log sai

---

# 23. AUTOMATION TEST

Khuyến khích

Tự động chạy toàn bộ test.

Ví dụ

Run All API Tests

↓

Run Module Tests

↓

Run Integration Tests

↓

Generate Report

---

# 24. TEST CHECKLIST

API

□ Input hợp lệ

□ Input không hợp lệ

□ Boundary

□ Unicode

□ ErrorLevel

□ Side Effect

□ Performance

□ Documentation

---

Module

□ Chạy độc lập

□ Không phụ thuộc caller

□ Không hard-code

□ Không leak Environment

□ Không đổi Current Directory

---

Integration

□ Module hoạt động cùng nhau

□ Data Flow đúng

□ Error truyền đúng

□ Không phát sinh vòng phụ thuộc

---

Regression

□ Test cũ đều Pass

□ Không sinh bug mới

□ Không thay đổi hành vi

---

# 25. TEST REPORT

Mỗi lần test nên ghi

Ngày

Người test

Phiên bản

Module

API

Kết quả

Pass

Fail

Blocked

Skipped

Bug phát hiện

Mức độ

Critical

High

Medium

Low

Khuyến nghị

Có cần sửa ngay không.

---

# 26. KẾT LUẬN

Mọi thay đổi trước khi Merge hoặc Release phải trải qua:

✓ API Test

✓ Module Test

✓ Integration Test

✓ Regression Test

Nếu bất kỳ bài kiểm thử quan trọng nào thất bại, không được coi phiên bản là sẵn sàng phát hành.