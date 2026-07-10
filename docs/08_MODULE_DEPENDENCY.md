# MODULE DEPENDENCY GUIDE

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# Mục đích

Tài liệu này quy định mối quan hệ phụ thuộc (Dependency) giữa các module trong dự án.

Mục tiêu:

- Giảm Coupling
- Tăng Maintainability
- Dễ Refactor
- Dễ Test
- Tránh Circular Dependency
- Cho phép thay thế module mà không ảnh hưởng toàn hệ thống

---

# Dependency Rule

Luật quan trọng nhất

Dependency chỉ được đi từ trên xuống.

Không được phụ thuộc ngược.

Ví dụ

Main

↓

Menu

↓

Search

↓

Scan

↓

Core

KHÔNG BAO GIỜ

Core

↓

Scan

---

# Kiến trúc tổng thể

99_Main.bat

↓

90_Bootstrap.bat

↓

03_Menu.bat

↓

04_Search.bat

↓

02_Scan.bat

↓

05_Export.bat

↓

06_Statistics.bat

↓

07_Progress.bat

↓

08_Cleanup.bat

↓

01_Core.bat

Core luôn ở đáy.

Core không được phụ thuộc module khác.

---

# Module Layer

## Layer 1

Application Layer

Bao gồm

99_Main.bat

Vai trò

- Entry Point
- Điều phối toàn bộ chương trình

Không chứa Business Logic.

---

## Layer 2

Bootstrap Layer

90_Bootstrap.bat

Nhiệm vụ

- Kiểm tra môi trường
- Khởi tạo biến
- Load module

---

## Layer 3

Presentation Layer

03_Menu.bat

Nhiệm vụ

- Hiển thị Menu
- Nhận Input

Không xử lý nghiệp vụ.

---

## Layer 4

Business Layer

02_Scan.bat

04_Search.bat

05_Export.bat

06_Statistics.bat

07_Progress.bat

08_Cleanup.bat

Đây là nơi xử lý logic.

---

## Layer 5

Core Layer

01_Core.bat

Đây là module nền.

Bao gồm

- String API
- Path API
- File API
- Array API
- Validation API
- Utility API

Không chứa Business Logic.

---

# Allowed Dependency

## Main

Được phép gọi

Bootstrap

Menu

Core

Không gọi trực tiếp Utility nhỏ nếu Menu đã xử lý.

---

## Menu

Được phép gọi

Search

Scan

Export

Statistics

Core

---

## Search

Được phép gọi

Core

Không gọi

Export

Cleanup

Menu

---

## Scan

Được phép gọi

Core

Không gọi

Menu

Main

Export

---

## Export

Được phép gọi

Core

Statistics

Không gọi

Main

Menu

---

## Statistics

Được phép gọi

Core

---

## Cleanup

Được phép gọi

Core

---

## Core

Không được gọi

BẤT KỲ module nào.

---

# Circular Dependency

Không được tồn tại.

Ví dụ sai

Scan

↓

Core

↓

Scan

Sai.

---

Ví dụ khác

Export

↓

Statistics

↓

Export

Sai.

---

# Core Independence

Core phải độc lập.

Core không được biết:

Menu

Search

Scan

Export

Statistics

Cleanup

Main

Bootstrap

Core chỉ biết chính nó.

---

# API Dependency

Một API chỉ được gọi API cùng module hoặc Core.

Ví dụ

Scan_FindFile()

↓

Core.NormalizePath()

Đúng.

---

Ví dụ

Scan_FindFile()

↓

Export_Save()

Sai.

---

# Shared Logic

Nếu hai module dùng chung logic.

KHÔNG copy.

Đưa vào Core.

Ví dụ

Path Normalize

↓

Core.NormalizePath()

Không để:

Scan.Normalize()

Export.Normalize()

Statistics.Normalize()

---

# Dependency Injection

Batch Script không có DI thực sự.

Thay vào đó

Truyền dữ liệu bằng Parameter.

Không dùng Global Variable nếu có thể.

Ví dụ

call Core.Normalize "%INPUT%"

Đúng.

---

set INPUT=...

call Core.Normalize

Sai.

---

# Global Variable

Chỉ dùng cho

Application Configuration

Ví dụ

APP_NAME

PROJECT_PATH

VERSION

BUILD_DATE

---

Không dùng

CURRENT_FILE

TEMP_PATH

CURRENT_INDEX

SCAN_RESULT

Các biến này phải truyền qua Parameter.

---

# Cross Module Communication

Sai

Scan

↓

set RESULT=...

↓

Export đọc RESULT

---

Đúng

Scan

↓

call Export.Save "%RESULT%"

---

# Event Flow

Main

↓

Menu

↓

Scan

↓

Export

↓

Statistics

↓

Cleanup

↓

Exit

---

# Data Flow

Input

↓

Validate

↓

Normalize

↓

Business Logic

↓

Output

---

# Call Chain

Không vượt quá

5 cấp.

Ví dụ

Main

↓

Menu

↓

Scan

↓

Core

↓

Utility

OK

---

Main

↓

Menu

↓

Scan

↓

Export

↓

Statistics

↓

Cleanup

↓

Core

Quá sâu.

Nên Refactor.

---

# Module Size

Khuyến nghị

Core

1000+

được phép.

Business Module

300~700 dòng.

Nếu

>1000 dòng

Cần xem xét chia module.

---

# Cohesion

Module chỉ nên có

Một trách nhiệm chính.

Ví dụ

Search

Chỉ tìm kiếm.

Không Export.

Không Statistics.

---

# Coupling

Mỗi module chỉ biết

Core

và

Caller trực tiếp.

Không biết toàn bộ hệ thống.

---

# Dependency Checklist

## Architecture

□ Có Circular Dependency không?

□ Core có phụ thuộc module khác không?

□ Dependency có đi một chiều không?

□ Có gọi chéo Business Module không?

□ Có tách Layer đúng không?

---

## API

□ API có độc lập không?

□ API có phụ thuộc Caller không?

□ API có dùng Global Variable không?

□ API có side effect không?

□ API có thay đổi Environment không?

---

## Maintainability

□ Có logic trùng lặp không?

□ Có thể chuyển vào Core không?

□ Có module quá lớn không?

□ Có module làm quá nhiều việc không?

---

## Reusability

□ API có dùng lại được không?

□ Có Hard-code module name không?

□ Có Hard-code path không?

□ Có phụ thuộc Business Logic không?

---

# Red Flags

Review phải đánh dấu High/Critical nếu phát hiện

■ Circular Dependency

■ Core gọi Business Module

■ Business Module gọi chéo nhau

■ Dùng Global Variable để truyền dữ liệu

■ API phụ thuộc Caller

■ Copy/Paste logic giữa module

■ Module có nhiều hơn một trách nhiệm

■ Coupling quá cao

---

# Mục tiêu cuối cùng

Kiến trúc của MPLAB_SOURCE_EXPORT_TOOL phải đạt:

- Layer rõ ràng
- Core độc lập
- Business độc lập
- API tái sử dụng
- Không Circular Dependency
- Coupling thấp
- Cohesion cao
- Dễ kiểm thử
- Dễ mở rộng
- Dễ bảo trì
- Refactor an toàn