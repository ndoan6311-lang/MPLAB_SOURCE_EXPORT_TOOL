# REPORT TEMPLATE

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC TIÊU

Tất cả báo cáo review phải sử dụng cùng một cấu trúc.

Mục tiêu:

- Dễ đọc
- Dễ so sánh
- Dễ theo dõi
- Dễ lưu trữ
- Không bỏ sót vấn đề

Không thay đổi cấu trúc nếu không có yêu cầu.

---

# QUY TẮC CHUNG

Review phải:

- Khách quan
- Có bằng chứng
- Có giải thích
- Có mức độ ưu tiên

Không được:

- Chỉ nêu kết luận
- Phán đoán khi thiếu ngữ cảnh
- Chỉ chê mà không đưa giải pháp

---

# MẪU BÁO CÁO

# Code Review Report

---

## 1. Executive Summary

Mô tả ngắn gọn:

- Module đang làm gì
- Chất lượng tổng thể
- Có nên sửa ngay hay không

Ví dụ:

Module có kiến trúc rõ ràng.

API khá tốt.

Tuy nhiên còn tồn tại một số lỗi về Dependency và Delayed Expansion cần ưu tiên xử lý.

---

## 2. Scope

Đã review:

- File
- Module
- API

Ví dụ

Reviewed Files

- 01_Core.bat

Reviewed APIs

- Core_CopyFile
- Core_GetRelativePath

---

## 3. Strengths

Liệt kê các điểm tốt.

Ví dụ

✓ API chia nhỏ hợp lý

✓ Không duplicated code

✓ Naming rõ ràng

✓ Return Code thống nhất

✓ Documentation tốt

---

## 4. Findings

Liệt kê tất cả vấn đề.

Mỗi vấn đề gồm:

ID

↓

Title

↓

Severity

↓

Description

↓

Evidence

↓

Recommendation

---

Ví dụ

### BUG-001

Severity

High

Title

API phụ thuộc Delayed Expansion

Description

Core_GetRelativePath yêu cầu caller EnableDelayedExpansion.

Điều này làm tăng Coupling.

Evidence

API sử dụng !VARIABLE! nhưng không tự EnableDelayedExpansion.

Recommendation

API tự quản lý Delayed Expansion.

---

## 5. Architecture Review

Đánh giá:

- Module Design
- Dependency
- Coupling
- Cohesion

Ví dụ

Architecture

8/10

Nhận xét

Module được tách tương đối tốt.

Tuy nhiên Core vẫn phụ thuộc trạng thái caller.

---

## 6. API Review

Đánh giá:

Input

Output

Return Code

Contract

Side Effect

Dependency

Ví dụ

API

Core_GetRelativePath

Input

Đạt

Output

Đạt

Return Code

Đạt

Dependency

Chưa đạt

---

## 7. Code Quality

Đánh giá

Duplicate Code

Code Smell

Magic Number

Hard-code

Dead Code

Readability

Maintainability

Ví dụ

Duplicate

Không

Magic Number

Có

Hard-code

Không

---

## 8. Batch Script Review

Đánh giá riêng cho Batch.

Checklist

□ Delayed Expansion

□ ErrorLevel

□ Variable Scope

□ Current Directory

□ Environment

□ Path

□ Quote

□ Escape

□ Unicode

□ Performance

□ CALL

□ EXIT /B

□ SETLOCAL

□ ENDLOCAL

□ Side Effect

□ Hidden Dependency

---

## 9. Risk Assessment

Đánh giá rủi ro.

Ví dụ

Critical

0

High

2

Medium

4

Low

6

---

## 10. Refactor Suggestions

Mỗi đề xuất gồm:

Title

Reason

Benefit

Risk

Priority

Ví dụ

REF-001

Title

Tách API NormalizePath

Reason

Đang duplicated tại 3 nơi.

Benefit

Giảm Duplicate.

Risk

Thấp.

Priority

Medium.

---

## 11. Priority Matrix

Critical

Sửa ngay.

High

Sửa trước release.

Medium

Lên kế hoạch.

Low

Có thể để sau.

---

## 12. Overall Score

Architecture

9/10

API

8/10

Maintainability

8/10

Performance

9/10

Readability

9/10

Security

10/10

Batch Standard

8/10

Overall

8.7/10

---

## 13. Final Conclusion

Tóm tắt toàn bộ.

Ví dụ

Module đạt chất lượng khá.

Kiến trúc tốt.

API còn một số điểm cần cải thiện về tính độc lập.

Không phát hiện lỗi Critical.

Khuyến nghị sửa các lỗi High trước khi phát triển thêm.

---

# QUY TẮC CHẤM ĐIỂM

10

Không phát hiện vấn đề.

9

Có vài vấn đề nhỏ.

8

Có một số vấn đề Medium.

7

Có nhiều vấn đề High.

6 trở xuống

Có vấn đề nghiêm trọng.

---

# QUY TẮC ĐÁNH MỨC ĐỘ

Critical

- Sai kết quả
- Mất dữ liệu
- Crash
- Corrupt dữ liệu

High

- API sai
- Architecture sai
- Hidden Dependency
- Side Effect nguy hiểm

Medium

- Duplicate Code
- Hard-code
- Maintainability thấp

Low

- Naming
- Comment
- Formatting

---

# QUY TẮC ĐỀ XUẤT

Mọi đề xuất phải trả lời được:

- Vấn đề là gì?
- Vì sao cần sửa?
- Nếu không sửa sẽ ảnh hưởng gì?
- Giải pháp là gì?
- Có nhược điểm gì?
- Mức độ ưu tiên?

Không đề xuất chỉ vì sở thích cá nhân.

---

# AI REVIEW RULE

AI phải:

✓ Có bằng chứng.

✓ Có giải thích.

✓ Có mức độ ưu tiên.

✓ Có giải pháp.

✓ Có đánh giá ảnh hưởng.

Không được:

✗ Chỉ nói "nên".

✗ Chỉ nói "có thể".

✗ Chỉ nói "tốt hơn".

Phải giải thích lý do.

---

# KẾT LUẬN

Mọi báo cáo review trong dự án phải tuân thủ mẫu này để đảm bảo:

- Thống nhất.
- Dễ theo dõi.
- Dễ so sánh.
- Dễ cải tiến.
- Có thể sử dụng với ChatGPT, Gemini, Claude và Continue.