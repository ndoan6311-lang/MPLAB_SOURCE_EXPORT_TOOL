# CODE REVIEW STANDARD

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC TIÊU

Review nhằm đảm bảo:

- Tính đúng đắn (Correctness)
- Tính ổn định (Reliability)
- Khả năng bảo trì (Maintainability)
- Khả năng mở rộng (Extensibility)
- Khả năng tái sử dụng (Reusability)
- Hiệu năng (Performance)
- Kiến trúc (Architecture)

Review không nhằm:

- Bắt lỗi chính tả
- Ép theo phong cách cá nhân
- Refactor để "đẹp hơn"

---

# REVIEW ORDER

Luôn review theo thứ tự sau:

1. Correctness
2. Bug
3. Architecture
4. API
5. Maintainability
6. Reusability
7. Extensibility
8. Performance
9. Readability
10. Coding Style

Không được đảo thứ tự.

---

# 1. CORRECTNESS

Kiểm tra:

□ Code có đúng yêu cầu không

□ Có xử lý đầy đủ mọi trường hợp không

□ Có trả kết quả sai không

□ Có Undefined Behavior không

□ Có Logic Error không

□ Có Edge Case chưa xử lý không

□ Có Null Case không

□ Có Empty Input không

□ Có Invalid Input không

□ Có Overflow không

□ Có Underflow không

□ Có Infinite Loop không

□ Có Deadlock (nếu có)

□ Có xử lý lỗi đầy đủ không

---

# 2. BUG REVIEW

Kiểm tra:

□ Bug logic

□ Bug runtime

□ Bug tiềm ẩn

□ Sai điều kiện

□ Sai thứ tự xử lý

□ Sai giá trị mặc định

□ Sai Error Handling

□ Race Condition (nếu có)

□ Resource Leak

□ Memory Leak (nếu có)

□ File Handle Leak

□ Exception chưa xử lý

---

# 3. ARCHITECTURE REVIEW

Kiểm tra:

□ Module có đúng trách nhiệm không

□ Có vi phạm Single Responsibility không

□ Có phụ thuộc vòng không

□ Coupling có quá cao không

□ Cohesion có tốt không

□ Có chia module hợp lý không

□ Có module quá lớn không

□ Có API chồng chéo không

□ Có Dependency không cần thiết không

□ Có Circular Dependency không

---

# 4. API REVIEW

Kiểm tra:

□ API có rõ ràng không

□ API có tự mô tả không

□ Input rõ ràng không

□ Output rõ ràng không

□ Return Value hợp lý không

□ Error Code thống nhất không

□ Có Side Effect không

□ Có phụ thuộc Caller không

□ Có sử dụng Global State không

□ Có Hidden Dependency không

□ Có thể tái sử dụng không

□ Có dễ test không

---

# 5. MAINTAINABILITY

Kiểm tra:

□ Code dễ đọc không

□ Có Comment cần thiết không

□ Có Comment dư không

□ Có Hard-code không

□ Có Magic Number không

□ Có Magic String không

□ Có Dead Code không

□ Có Duplicate Logic không

□ Có Function quá dài không

□ Có Module quá lớn không

□ Có quá nhiều if lồng nhau không

□ Có quá nhiều switch không

□ Có quá nhiều flag không

---

# 6. REUSABILITY

Kiểm tra:

□ Có logic lặp không

□ Có thể tách API chung không

□ Có helper dùng chung không

□ Có module dùng lại được không

□ Có code copy/paste không

---

# 7. EXTENSIBILITY

Kiểm tra:

□ Thêm chức năng mới có khó không

□ Có phải sửa nhiều module không

□ Có Open/Closed Principle không

□ Có phụ thuộc cứng không

□ Có hard-code interface không

---

# 8. PERFORMANCE

Kiểm tra:

□ Thuật toán hợp lý không

□ Có loop dư không

□ Có scan lặp lại dữ liệu không

□ Có tạo object dư không

□ Có I/O dư không

□ Có cache cần thiết không

□ Có bottleneck rõ ràng không

Không tối ưu nếu không mang lại lợi ích đáng kể.

---

# 9. READABILITY

Kiểm tra:

□ Tên biến rõ nghĩa

□ Tên hàm rõ nghĩa

□ Tên module rõ nghĩa

□ Định dạng thống nhất

□ Khoảng trắng hợp lý

□ Dễ đọc

□ Dễ hiểu

---

# 10. CONSISTENCY

Kiểm tra:

□ Quy tắc đặt tên thống nhất

□ API thống nhất

□ Error Code thống nhất

□ Logging thống nhất

□ Comment thống nhất

□ Coding Style thống nhất

---

# CODE SMELL

Luôn phát hiện:

□ Duplicate Code

□ Long Function

□ Long Parameter List

□ Feature Envy

□ God Module

□ Shotgun Surgery

□ Data Clump

□ Primitive Obsession

□ Hidden Dependency

□ Tight Coupling

□ Dead Code

□ Magic Number

□ Hard-code

---

# SECURITY

Nếu liên quan:

Kiểm tra:

□ Input Validation

□ Command Injection

□ Path Traversal

□ Buffer Overflow

□ Information Disclosure

□ Hard-code Password

□ Hard-code Secret

□ Hard-code Token

---

# DOCUMENTATION

Kiểm tra:

□ API có tài liệu không

□ Comment có đúng không

□ README cập nhật không

□ Tài liệu có lỗi thời không

---

# REFACTOR RULES

Chỉ đề xuất refactor khi:

✓ Giảm Coupling

✓ Giảm Duplicate

✓ Dễ Test

✓ Dễ Maintain

✓ Dễ Extend

Không refactor chỉ để:

✗ Đổi style

✗ Đổi tên

✗ Viết ngắn hơn

✗ Theo sở thích

---

# MỨC ĐỘ

Critical

- Sai kết quả
- Crash
- Mất dữ liệu
- Lỗi nghiêm trọng

High

- Bug tiềm ẩn
- API sai
- Architecture sai
- Coupling cao

Medium

- Duplicate
- Code Smell
- Maintainability thấp

Low

- Readability
- Style
- Comment

---

# BÁO CÁO REVIEW

Luôn trả lời theo cấu trúc sau:

## 1. Tổng quan

Mục đích của module.

---

## 2. Điểm mạnh

Các điểm thiết kế tốt.

---

## 3. Điểm yếu

Các vấn đề cần cải thiện.

---

## 4. Bug

Liệt kê bug.

Đánh giá mức độ.

Giải thích nguyên nhân.

---

## 5. Architecture

Đánh giá kiến trúc.

---

## 6. API

Đánh giá API.

---

## 7. Maintainability

Đánh giá khả năng bảo trì.

---

## 8. Refactor

Đề xuất nếu cần.

Không bắt buộc.

---

## 9. Kết luận

Tổng hợp.

Đánh giá chất lượng.

Đưa ra mức độ:

Critical

High

Medium

Low