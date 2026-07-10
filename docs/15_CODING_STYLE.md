# CODING STYLE GUIDE

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC ĐÍCH

Tài liệu này quy định Coding Style thống nhất cho toàn bộ dự án.

Mục tiêu

- Code dễ đọc
- Code nhất quán
- Dễ Review
- Dễ Maintain
- Dễ Refactor
- Giảm Bug

---

# NGUYÊN TẮC

Code được viết cho con người đọc trước.

Máy tính chỉ là người thực thi.

Ưu tiên

Correctness

↓

Maintainability

↓

Readability

↓

Performance

↓

Style

Style không bao giờ quan trọng hơn Bug.

---

# MỘT HÀM CHỈ LÀM MỘT VIỆC

Đúng

Core.NormalizePath()

Chỉ Normalize Path.

Sai

Core.NormalizePath()

↓

Normalize

↓

Check Exists

↓

Create Folder

↓

Export

---

# KÍCH THƯỚC API

Khuyến nghị

20~80 dòng

Nếu

>150 dòng

Cần xem xét tách nhỏ.

---

# KÍCH THƯỚC MODULE

Khuyến nghị

300~700 dòng

Nếu

>1000 dòng

Phải xem xét chia module.

---

# ĐỘ SÂU LỒNG NHAU

Không quá

3 cấp.

Ví dụ

IF

↓

FOR

↓

IF

Được.

---

IF

↓

FOR

↓

IF

↓

FOR

↓

IF

Không nên.

---

# LABEL

Đúng

:Core_NormalizePath

:Scan_Project

:Export_Report

Sai

:abc

:test

:new

:label1

---

# API PREFIX

Core_

Scan_

Search_

Export_

Menu_

Progress_

Cleanup_

Statistics_

Bootstrap_

Config_

Không dùng

DoWork

Test

Run

Process

---

# BIẾN

Tên biến phải mô tả ý nghĩa.

Đúng

CURRENT_FILE

PROJECT_PATH

OUTPUT_FOLDER

EXPORT_COUNT

Sai

A

TMP1

DATA

VALUE

---

# CONSTANT

Hằng số

Viết HOA.

Ví dụ

APP_NAME

RC_SUCCESS

MAX_PATH_LENGTH

BAR_WIDTH

---

# BIẾN TẠM

Prefix

TMP_

Ví dụ

TMP_PATH

TMP_FILE

TMP_BUFFER

---

# BIẾN ĐẾM

Tên rõ ràng

INDEX

ROW_INDEX

FILE_COUNT

MATCH_COUNT

Không dùng

I

J

K

(trừ Loop rất ngắn)

---

# BOOLEAN

Quy ước

0

1

Tên

IS_

HAS_

CAN_

Ví dụ

IS_VALID

HAS_ERROR

CAN_EXPORT

---

# PARAMETER

Tên rõ nghĩa.

Không dùng

%1

%2

Trong Comment.

Ví dụ

InputPath

OutputPath

---

# QUOTE

Luôn Quote

Đúng

set "FILE=%~1"

if exist "%FILE%"

Sai

set FILE=%1

if exist %FILE%

---

# SET

Luôn dùng

set "VAR=value"

Không dùng

set VAR=value

---

# IF

Đúng

if defined VAR

if not exist "%FILE%"

Sai

if "%VAR%"=="" ...

(nếu có thể dùng cách tốt hơn)

---

# CALL

Đúng

call :Core_CopyFile

Sai

goto Core_CopyFile

---

# RETURN

Luôn

exit /b RC_xxx

Không dùng

goto:eof

để báo lỗi.

---

# ERRORLEVEL

Kiểm tra ngay sau CALL.

Đúng

call ...

if errorlevel 1 ...

Sai

call ...

echo Done

if errorlevel 1 ...

---

# MAGIC NUMBER

Không dùng

120

255

4096

Trực tiếp.

Đúng

MAX_PATH_LENGTH

BAR_WIDTH

---

# HARD-CODE

Không Hard-code

Path

File

Folder

Configuration

Error Code

---

# DUPLICATE

Không Copy/Paste.

Nếu dùng

≥2 lần

Xem xét đưa vào Core.

---

# COMMENT

Comment giải thích

Tại sao.

Không giải thích

Code đang làm gì.

---

Sai

set COUNT=0

:: Set COUNT = 0

---

Đúng

:: Reset bộ đếm trước khi bắt đầu Scan.

set COUNT=0

---

# COMMENT STYLE

Đúng

========================================================

Core.NormalizePath

========================================================

Sai

******

--------------

/////////////

---

# KHOẢNG TRẮNG

Một dòng trống

Giữa

Hai API.

Không quá nhiều dòng trống.

---

# CĂN LỀ

Indent

4 Space.

Không Tab.

---

# LINE LENGTH

Khuyến nghị

≤120 ký tự.

Nếu dài

Chia nhỏ.

---

# NESTED IF

Không quá

3 cấp.

Nếu nhiều hơn

Tách API.

---

# GLOBAL VARIABLE

Chỉ dùng

Configuration

Không dùng

Runtime Data.

---

# SIDE EFFECT

API không được

Đổi

Current Directory

PATH

Code Page

Environment

Nếu có

Phải Restore.

---

# LOGGING

Business Layer

Mới được Log.

Core

Không Log.

---

# OUTPUT

Một API

↓

Một nhiệm vụ.

↓

Một Return Code.

↓

Một Output chính.

---

# DOCUMENTATION

Public API

Phải có

Tên

Mục đích

Input

Output

Return Code

Side Effect

Ví dụ

========================================================

Core.NormalizePath

Purpose

Normalize Path.

Input

Raw Path

Output

Normalized Path

Return

RC_SUCCESS

RC_INVALID_PATH

========================================================

---

# CHECKLIST

## Naming

□ API rõ nghĩa

□ Variable rõ nghĩa

□ Constant viết HOA

□ Prefix đúng

---

## Formatting

□ Quote đầy đủ

□ set "VAR=value"

□ Indent 4 Space

□ Không Tab

---

## Code

□ Không Magic Number

□ Không Hard-code

□ Không Duplicate

□ Không Dead Code

---

## Architecture

□ Một API một nhiệm vụ

□ Một Module một trách nhiệm

□ Không Side Effect

□ Không Hidden Dependency

---

## Documentation

□ Có Comment

□ Có API Header

□ Có Return Code

□ Có Example nếu cần

---

# RED FLAGS

Critical

■ API làm nhiều việc

■ Hidden Dependency

■ Side Effect

■ Environment Pollution

High

■ Hard-code

■ Duplicate Code

■ Magic Number

■ God Function

■ God Module

Medium

■ Tên khó hiểu

■ Comment sai

■ Indent không thống nhất

Low

■ Formatting

■ Khoảng trắng

■ Thứ tự Comment

---

# VÍ DỤ

Đúng

========================================================
Core.CopyFile
========================================================

call :Core_CopyFile "%SRC%" "%DST%"

if errorlevel 1 exit /b %ERRORLEVEL%

---

Sai

copy %1 %2

goto:eof

---

# MỤC TIÊU CUỐI CÙNG

Toàn bộ mã nguồn phải đạt

- Dễ đọc
- Dễ Review
- Dễ Test
- Dễ Maintain
- Dễ Refactor
- Không Hard-code
- Không Duplicate
- Không Hidden Dependency
- Không Side Effect
- Coding Style thống nhất