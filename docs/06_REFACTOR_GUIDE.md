# REFACTOR GUIDE

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC LỤC

1. Mục tiêu
2. Định nghĩa Refactor
3. Khi nào nên Refactor
4. Khi nào KHÔNG nên Refactor
5. Nguyên tắc Refactor
6. Refactor Priority
7. Refactor Checklist
8. Anti-pattern
9. Batch Script Refactor
10. Refactor Report

---

# 1. MỤC TIÊU

Refactor nhằm:

- Giảm độ phức tạp
- Giảm Coupling
- Tăng Cohesion
- Tăng Maintainability
- Tăng Reusability
- Tăng Testability
- Tăng Extensibility

Không nhằm:

- Làm đẹp code
- Thể hiện kỹ năng
- Đổi phong cách lập trình

---

# 2. ĐỊNH NGHĨA

Refactor là:

Thay đổi cấu trúc nội bộ của source code.

Không thay đổi hành vi.

Nếu hành vi thay đổi thì đó là Feature hoặc Bug Fix.

Không phải Refactor.

---

# 3. KHI NÀO NÊN REFACTOR

Chỉ nên Refactor nếu:

✓ Giảm Duplicate Code

✓ API rõ ràng hơn

✓ Giảm Coupling

✓ Tăng Cohesion

✓ Dễ đọc hơn

✓ Dễ bảo trì hơn

✓ Dễ kiểm thử hơn

✓ Dễ mở rộng hơn

✓ Giảm Side Effect

---

# 4. KHI NÀO KHÔNG NÊN REFACTOR

Không Refactor nếu:

✗ Chỉ đổi Coding Style

✗ Chỉ đổi tên biến

✗ Chỉ đổi format

✗ Chỉ đổi thứ tự code

✗ Chỉ để "đẹp hơn"

✗ Không mang lại lợi ích rõ ràng

---

# 5. NGUYÊN TẮC

Mọi Refactor phải:

✓ Giữ nguyên Behavior

✓ Giữ nguyên Output

✓ Giữ nguyên Return Code

✓ Giữ nguyên API Contract

✓ Giữ nguyên Side Effect (nếu là hành vi đã được định nghĩa)

Không được:

- thêm Feature
- sửa Bug ngoài phạm vi yêu cầu
- tối ưu hóa ngoài phạm vi

---

# 6. THỨ TỰ ƯU TIÊN

Luôn Refactor theo thứ tự:

1. Bug
2. Architecture
3. API
4. Maintainability
5. Performance
6. Readability
7. Style

Không bao giờ ưu tiên Style trước Bug.

---

# 7. CÁC LOẠI REFACTOR

## Duplicate Code

Nên:

- Tách API dùng chung

Không nên:

- Copy/Paste

---

## Long Function

Nếu Function quá dài:

- Chia thành API nhỏ

Nhưng:

Không chia quá mức.

---

## Magic Number

Đưa thành Constant.

Ví dụ:

1024

↓

MAX_BUFFER_SIZE

---

## Hard-code

Đưa thành:

- Constant
- Configuration
- Parameter

---

## Deep Nesting

Giảm số tầng IF.

Ưu tiên:

Early Return

Hoặc:

Tách API.

---

## Large Module

Chia module theo:

Trách nhiệm.

Không chia theo số dòng.

---

## Hidden Dependency

Loại bỏ:

Global Variable

Environment Dependency

Caller Dependency

---

## Side Effect

Nếu API thay đổi môi trường:

- Tài liệu hóa

hoặc

- Loại bỏ

---

# 8. REFACTOR CHECKLIST

## Architecture

□ Giảm Coupling

□ Tăng Cohesion

□ Không Circular Dependency

---

## API

□ API rõ hơn

□ Ít Side Effect hơn

□ Không Hidden Dependency

---

## Maintainability

□ Dễ đọc hơn

□ Ít Duplicate hơn

□ Ít Hard-code hơn

---

## Extensibility

□ Dễ mở rộng

□ Dễ thêm chức năng

---

## Performance

□ Không chậm hơn

Hoặc

□ Có cải thiện rõ ràng

---

## Compatibility

□ Không Breaking Change

□ Không đổi Return Code

□ Không đổi API

□ Không đổi Output

---

# 9. BATCH SCRIPT

Đối với Batch Script.

Ưu tiên Refactor:

✓ API độc lập

✓ Không phụ thuộc Caller

✓ Không Global Variable

✓ Restore Environment

✓ Restore Current Directory

✓ Restore Delayed Expansion

✓ Return Code thống nhất

Không Refactor chỉ để:

- Viết ngắn hơn

- Ít dòng hơn

- Dùng cú pháp "cao siêu"

---

# 10. CHI PHÍ REFACTOR

Mọi đề xuất Refactor phải đánh giá:

Lợi ích

↓

Chi phí

↓

Rủi ro

↓

Ảnh hưởng

Không đề xuất Refactor nếu:

Chi phí lớn hơn lợi ích.

---

# 11. BÁO CÁO REFACTOR

Mỗi đề xuất phải có:

## Vấn đề

...

---

## Nguyên nhân

...

---

## Giải pháp

...

---

## Lợi ích

...

---

## Rủi ro

...

---

## Ảnh hưởng

...

---

## Mức độ

Critical

High

Medium

Low

---

# 12. AI REVIEW RULE

AI không được đề xuất Refactor nếu:

- Chỉ là sở thích cá nhân.
- Không cải thiện chất lượng.
- Không có bằng chứng.
- Chỉ đổi tên.
- Chỉ đổi style.

Mọi đề xuất phải giải thích:

✓ Vì sao.

✓ Lợi ích.

✓ Nhược điểm.

✓ Ảnh hưởng.

---

# KẾT LUẬN

Một Refactor được xem là đạt chuẩn khi:

✓ Không thay đổi hành vi.

✓ Cải thiện chất lượng source code.

✓ Có lợi ích rõ ràng.

✓ Không tạo Breaking Change.

✓ Không tăng độ phức tạp.

✓ Có thể kiểm thử độc lập.

Nếu không đáp ứng các tiêu chí trên thì không nên Refactor.