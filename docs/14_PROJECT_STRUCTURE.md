# PROJECT STRUCTURE

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC ĐÍCH

Tài liệu này quy định cấu trúc thư mục chuẩn của dự án.

Mục tiêu

- Dễ tìm kiếm
- Dễ mở rộng
- Dễ bảo trì
- Dễ review
- Dễ tự động hóa
- Không trùng lặp

---

# NGUYÊN TẮC

Mỗi thư mục chỉ có một trách nhiệm.

Không trộn lẫn

- Source
- Document
- Test
- Build
- Release

---

# CẤU TRÚC TỔNG THỂ

```
MPLAB_SOURCE_EXPORT_TOOL/
│
├── modules/
├── docs/
├── tests/
├── examples/
├── output/
├── temp/
├── tools/
├── scripts/
├── assets/
├── release/
│
├── 99_Main.bat
├── LICENSE
├── README.md
└── CHANGELOG.md
```

---

# ROOT DIRECTORY

Root chỉ chứa

- Entry Point
- README
- License
- Changelog

Không đặt

Business Module

Utility

Temporary File

---

# MODULES

```
modules/
```

Chứa toàn bộ mã nguồn.

Ví dụ

```
modules/

00_Config.bat

01_Core.bat

02_Scan.bat

03_Menu.bat

04_Search.bat

05_Export.bat

06_Statistics.bat

07_Progress.bat

08_Cleanup.bat

90_Bootstrap.bat
```

---

Không đặt

README

Document

Test

Output

---

# DOCS

```
docs/
```

Chứa toàn bộ tài liệu.

Ví dụ

```
docs/

00_AI_SYSTEM_RULES.md

01_CODE_REVIEW_STANDARD.md

...

CHECKLIST.md
```

Không chứa

Code

---

# TESTS

```
tests/
```

Chứa toàn bộ Test.

Ví dụ

```
tests/

api/

module/

integration/

regression/

performance/
```

---

# API TEST

```
tests/api/
```

Một API

↓

Một Test.

Ví dụ

```
Core.NormalizePath.test.bat

Core.CopyFile.test.bat

Core.FileExists.test.bat
```

---

# MODULE TEST

```
tests/module/
```

Ví dụ

```
Scan.test.bat

Export.test.bat

Statistics.test.bat
```

---

# INTEGRATION TEST

```
tests/integration/
```

Ví dụ

```
ScanExport.test.bat

ExportStatistics.test.bat
```

---

# REGRESSION TEST

```
tests/regression/
```

Sau mỗi lần sửa

Phải chạy lại.

---

# EXAMPLES

```
examples/
```

Ví dụ

```
simple

advanced

demo
```

---

# OUTPUT

```
output/
```

Chỉ chứa

Generated File

Không Commit Git.

---

# TEMP

```
temp/
```

Chứa

Temporary File

Runtime File

Cache

Sau khi chạy

Phải Cleanup.

---

# TOOLS

```
tools/
```

Ví dụ

Formatter

Helper

Converter

Generator

---

# SCRIPTS

```
scripts/
```

Script hỗ trợ.

Ví dụ

Build

Test

Release

Package

---

# ASSETS

```
assets/
```

Ví dụ

Image

Icon

Logo

Banner

Không chứa Code.

---

# RELEASE

```
release/
```

Ví dụ

v1.0.0

v1.1.0

v2.0.0

---

# DOCUMENT

Root

↓

README.md

Project Overview

---

CHANGELOG.md

Version History

---

LICENSE

License

---

# MODULE RULE

Một Module

↓

Một File.

Không gộp nhiều Module.

---

# FILE SIZE

Khuyến nghị

<1000 dòng

Nếu lớn hơn

Xem xét chia Module.

---

# FILE NAMING

Đúng

01_Core.bat

02_Scan.bat

03_Menu.bat

Sai

abc.bat

new.bat

module1.bat

---

# DOCUMENT NAMING

Đúng

04_API_DESIGN_GUIDE.md

09_DATA_FLOW.md

Sai

Guide.md

API.md

Document.md

---

# TEST NAMING

Đúng

Core.CopyFile.test.bat

Scan.test.bat

Sai

test1.bat

abc_test.bat

---

# OUTPUT FILE

Không Commit

*.tmp

*.log

*.cache

*.bak

*.old

---

# BUILD FILE

Không Commit

*.obj

*.o

*.exe

*.dll

---

# MODULE DEPENDENCY

Main

↓

Bootstrap

↓

Business

↓

Core

Không ngược.

---

# DATA FLOW

Input

↓

Validate

↓

Normalize

↓

Process

↓

Output

---

# REVIEW CHECKLIST

## Structure

□ Đúng thư mục

□ Không lẫn Code và Document

□ Không lẫn Test

□ Không lẫn Output

---

## Module

□ Một Module một File

□ Không Circular Dependency

□ Không Duplicate

---

## Test

□ Có API Test

□ Có Module Test

□ Có Integration Test

□ Có Regression Test

---

## Documentation

□ Có README

□ Có CHANGELOG

□ Có Document

---

## Cleanup

□ Không File tạm

□ Không Cache

□ Không Log dư

---

# RED FLAGS

Critical

■ Code nằm sai thư mục

■ Business Module nằm trong Core

■ Circular Dependency

■ Test nằm chung Source

■ Output Commit Git

High

■ Thiếu Test

■ Thiếu Documentation

■ Module quá lớn

■ Duplicate Structure

Medium

■ Tên File không thống nhất

■ Thư mục thừa

Low

■ Sắp xếp chưa đẹp

---

# PROJECT STRUCTURE

```
MPLAB_SOURCE_EXPORT_TOOL/

│
├── docs/
│
├── modules/
│
├── tests/
│   ├── api/
│   ├── module/
│   ├── integration/
│   ├── regression/
│   └── performance/
│
├── examples/
│
├── output/
│
├── temp/
│
├── scripts/
│
├── tools/
│
├── assets/
│
├── release/
│
├── README.md
├── CHANGELOG.md
├── LICENSE
└── 99_Main.bat
```

---

# MỤC TIÊU CUỐI CÙNG

Cấu trúc dự án phải đảm bảo

- Rõ ràng
- Dễ tìm
- Dễ mở rộng
- Dễ kiểm thử
- Dễ Review
- Dễ Release
- Dễ bảo trì
- Không trùng lặp
- Không lẫn chức năng
- Tuân thủ kiến trúc Layer