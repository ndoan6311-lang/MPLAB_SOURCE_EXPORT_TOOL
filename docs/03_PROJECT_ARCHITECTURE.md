# PROJECT ARCHITECTURE

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC LỤC

1. Kiến trúc tổng thể
2. Nguyên tắc thiết kế
3. Cấu trúc thư mục
4. Vai trò từng module
5. Dependency Rules
6. Data Flow
7. Control Flow
8. Module Life Cycle
9. API Layer
10. Shared Resources
11. Error Handling
12. Logging
13. Coding Rules
14. Extension Guide
15. Architecture Checklist

---

# 1. KIẾN TRÚC TỔNG THỂ

Dự án được thiết kế theo kiến trúc Module-Based.

Mỗi module chịu trách nhiệm duy nhất cho một nhóm chức năng.

Không có module đa nhiệm.

Kiến trúc:

Application

↓

Main

↓

Feature Modules

↓

Core Library

↓

Windows CMD

---

# 2. NGUYÊN TẮC THIẾT KẾ

Áp dụng các nguyên tắc:

- Single Responsibility Principle
- High Cohesion
- Low Coupling
- Reusability
- Maintainability
- Extensibility
- Predictability

Không tối ưu bằng cách đánh đổi khả năng bảo trì.

---

# 3. CẤU TRÚC THƯ MỤC

```
MPLAB_SOURCE_EXPORT_TOOL/

docs/
examples/
modules/
release/

build.bat
README.md
LICENSE
```

---

## docs/

Chứa toàn bộ tài liệu kỹ thuật.

Không chứa mã nguồn.

---

## examples/

Ví dụ sử dụng API.

Không dùng trong Production.

---

## modules/

Chứa toàn bộ module.

Mỗi file chỉ đảm nhiệm một chức năng.

Ví dụ:

```
01_Core.bat
02_Scan.bat
03_Menu.bat
04_Search.bat
05_Export.bat
06_Statistics.bat
07_Progress.bat
08_Cleanup.bat
90_Bootstrap.bat
99_Main.bat
```

---

## release/

Thư mục build.

Không chỉnh sửa thủ công.

---

# 4. VAI TRÒ CÁC MODULE

## 01_Core.bat

Chứa:

- Utility API
- String API
- Path API
- File API
- Validation API
- Common API

Không chứa logic nghiệp vụ.

---

## 02_Scan.bat

Chịu trách nhiệm:

- Scan Source
- Scan Folder
- Scan Statistics

Không Export.

Không Menu.

---

## 03_Menu.bat

Hiển thị giao diện.

Không xử lý nghiệp vụ.

---

## 04_Search.bat

Tìm kiếm.

Không Scan.

Không Export.

---

## 05_Export.bat

Xuất Source.

Không Scan.

---

## 06_Statistics.bat

Thống kê.

Không thay đổi dữ liệu.

---

## 07_Progress.bat

Hiển thị Progress.

Không chứa Business Logic.

---

## 08_Cleanup.bat

Dọn dẹp.

Không xử lý nghiệp vụ khác.

---

## 90_Bootstrap.bat

Khởi tạo môi trường.

Load Module.

Kiểm tra điều kiện chạy.

---

## 99_Main.bat

Điểm bắt đầu chương trình.

Không chứa Business Logic.

Chỉ điều phối.

---

# 5. DEPENDENCY RULES

Cho phép:

Main

↓

Feature

↓

Core

Không được:

Core

↓

Feature

Hoặc

Feature A

↓

Feature B

nếu không thật sự cần.

---

Checklist

□ Không Circular Dependency

□ Không Hidden Dependency

□ Không gọi Label nội bộ module khác

□ Chỉ gọi Public API

---

# 6. DATA FLOW

Input

↓

Validation

↓

Processing

↓

Output

↓

Return Code

Không truyền dữ liệu bằng Global Variable nếu có thể truyền Parameter.

---

# 7. CONTROL FLOW

99_Main

↓

Bootstrap

↓

Menu

↓

Feature Module

↓

Core API

↓

Return

Control Flow chỉ đi một chiều.

---

# 8. MODULE LIFE CYCLE

Load

↓

Initialize

↓

Execute

↓

Cleanup

↓

Return

Mọi module phải kết thúc sạch.

---

# 9. API LAYER

API chia thành:

Public API

Internal API

Private Label

---

Public API

Cho phép module khác gọi.

---

Internal API

Chỉ module hiện tại sử dụng.

---

Private Label

Không được gọi từ ngoài.

---

# 10. SHARED RESOURCES

Các tài nguyên dùng chung gồm:

- Return Code
- Configuration
- Constants
- Temporary Files

Không chia sẻ trạng thái bằng Global Variable.

---

# 11. ERROR HANDLING

Mọi module:

Không Echo lỗi rồi tiếp tục.

Luôn:

Return Code

↓

Caller xử lý.

---

# 12. LOGGING

Module không tự ghi log nếu không được yêu cầu.

Nếu ghi log phải:

- thống nhất format
- có timestamp
- có module name

---

# 13. CODING RULES

Không Hard-code.

Không Copy/Paste.

Không Magic Number.

Không Side Effect.

Không sửa Environment nếu không cần.

---

# 14. EXTENSION GUIDE

Khi thêm module mới:

1.

Tạo file mới.

↓

2.

Định nghĩa Public API.

↓

3.

Review Dependency.

↓

4.

Review Naming.

↓

5.

Review Documentation.

↓

6.

Review Checklist.

---

# 15. ARCHITECTURE CHECKLIST

## Module

□ Single Responsibility

□ High Cohesion

□ Low Coupling

□ Reusable

□ Testable

□ Extensible

□ Maintainable

---

## API

□ Public rõ ràng

□ Không Side Effect

□ Không Hidden Dependency

□ Return Code thống nhất

□ Không phụ thuộc Caller

---

## Environment

□ Restore Environment

□ Restore Current Directory

□ Restore Delayed Expansion

□ Không làm bẩn Environment

---

## Dependency

□ Không Circular Dependency

□ Không gọi Internal Label

□ Chỉ gọi Public API

---

## Performance

□ Không Scan dư

□ Không Loop dư

□ Không tạo File tạm dư

□ Không Load Module dư

---

# KẾT LUẬN

Mục tiêu của kiến trúc dự án là:

- Dễ hiểu
- Dễ bảo trì
- Dễ mở rộng
- Dễ kiểm thử
- Dễ review
- Dễ tái sử dụng

Mọi thay đổi kiến trúc phải ưu tiên giữ ổn định API công khai để hạn chế ảnh hưởng đến các module khác.