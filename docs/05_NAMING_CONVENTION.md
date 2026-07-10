# NAMING CONVENTION

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC LỤC

1. Mục tiêu
2. Nguyên tắc chung
3. File Naming
4. Folder Naming
5. Module Naming
6. API Naming
7. Internal Label Naming
8. Variable Naming
9. Constant Naming
10. Return Code Naming
11. Temporary Variable
12. Boolean Variable
13. Documentation Naming
14. Examples
15. Checklist

---

# 1. MỤC TIÊU

Tên phải:

- Rõ ràng
- Dễ hiểu
- Có ý nghĩa
- Nhất quán
- Dễ tìm kiếm
- Dễ mở rộng

Không đặt tên theo cảm tính.

---

# 2. NGUYÊN TẮC CHUNG

Tên phải trả lời được:

- Đối tượng là gì?
- Chức năng là gì?
- Thuộc module nào?

Ưu tiên:

Dài nhưng rõ nghĩa

Không ưu tiên:

Ngắn nhưng khó hiểu.

---

# 3. FILE NAMING

Module sử dụng:

NN_ModuleName.bat

Ví dụ:

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

---

Không dùng:

test.bat

abc.bat

new.bat

temp.bat

copy.bat

---

# 4. FOLDER NAMING

Sử dụng PascalCase hoặc UPPER_CASE có chủ đích.

Ví dụ:

Modules

Docs

Examples

Release

Logs

Không dùng:

abc

folder1

new

temp

---

# 5. MODULE NAMING

Tên module là danh từ.

Ví dụ:

Core

Scan

Export

Search

Menu

Progress

Statistics

Cleanup

Không dùng động từ.

Sai:

Copy

Run

Execute

Do

---

# 6. API NAMING

Cú pháp:

Module_Action

Ví dụ:

Core_CopyFile

Core_DeleteFile

Core_CreateFolder

Core_PathNormalize

Core_GetRelativePath

Scan_Project

Export_Source

Menu_ShowMain

Statistics_Print

---

Quy tắc:

Module trước.

Động từ sau.

Object cuối.

Ví dụ:

Core_Copy_File

không khuyến khích.

Ưu tiên:

Core_CopyFile

---

Không dùng:

Do

Run

Work

Main

Temp

ABC

---

# 7. INTERNAL LABEL

Label nội bộ:

:_Tên

Ví dụ:

:_ParseLine

:_PrintHeader

:_SortList

:_CheckPath

Không gọi từ module khác.

---

Public API:

:Core_CopyFile

Internal:

:_CopyLoop

Private:

:_Exit

---

# 8. VARIABLE NAMING

Sử dụng:

UPPER_SNAKE_CASE

Ví dụ:

PROJECT_PATH

OUTPUT_PATH

SOURCE_FILE

TARGET_FOLDER

EXPORT_COUNT

CURRENT_LINE

MAX_LENGTH

ERROR_MESSAGE

Không dùng:

a

b

tmp

var

test

abc

---

Tên phải phản ánh nội dung.

Sai:

DATA

Đúng:

SOURCE_FILE_LIST

---

# 9. CONSTANT

Toàn bộ Constant:

UPPER_SNAKE_CASE

Ví dụ:

MAX_BUFFER_SIZE

DEFAULT_TIMEOUT

EMPTY_STRING

TRUE

FALSE

---

# 10. RETURN CODE

Tiền tố:

RC_

Ví dụ:

RC_SUCCESS

RC_INVALID_PARAMETER

RC_FILE_NOT_FOUND

RC_PATH_NOT_FOUND

RC_ACCESS_DENIED

RC_INTERNAL_ERROR

Không dùng:

ERR1

RET

RESULT

---

# 11. TEMP VARIABLE

Biến tạm phải có tiền tố:

TMP_

Ví dụ:

TMP_LINE

TMP_PATH

TMP_NAME

TMP_INDEX

Không tái sử dụng biến tạm cho nhiều mục đích.

---

# 12. BOOLEAN

Tiền tố:

IS_

HAS_

CAN_

NEED_

Ví dụ:

IS_VALID

HAS_ERROR

CAN_EXPORT

NEED_SCAN

Không dùng:

FLAG

STATE

VALUE

---

# 13. DOCUMENTATION

Tên tài liệu:

UPPER_CASE

Ví dụ:

README.md

CHANGELOG.md

LICENSE

API_DESIGN_GUIDE.md

PROJECT_ARCHITECTURE.md

BATCH_SCRIPT_STANDARD.md

---

# 14. EXAMPLES

Ví dụ tốt

Core_CopyFile

Core_DeleteFolder

Core_GetRelativePath

Export_Project

Scan_SourceFolder

Statistics_PrintSummary

Menu_ShowMain

---

Ví dụ chưa tốt

Run

Copy

DoExport

Test

ABC

Function1

Module2

MainAPI

---

# 15. CHECKLIST

## File

□ Có số thứ tự

□ Là danh từ

□ Rõ nghĩa

---

## Module

□ Một nhiệm vụ

□ Danh từ

□ Không viết tắt

---

## API

□ Có Module Prefix

□ Có Action

□ Có Object

□ Không viết tắt

---

## Variable

□ UPPER_SNAKE_CASE

□ Rõ nghĩa

□ Không quá ngắn

□ Không mơ hồ

---

## Constant

□ UPPER_SNAKE_CASE

□ Không thay đổi

---

## Boolean

□ IS_

□ HAS_

□ CAN_

□ NEED_

---

## Return Code

□ RC_

□ Thống nhất

---

# KẾT LUẬN

Một tên được xem là đạt chuẩn khi:

✓ Dễ hiểu.

✓ Có ý nghĩa.

✓ Nhất quán.

✓ Không cần đọc source vẫn đoán được chức năng.

✓ Hỗ trợ tìm kiếm nhanh trong IDE.

✓ Hỗ trợ mở rộng lâu dài.