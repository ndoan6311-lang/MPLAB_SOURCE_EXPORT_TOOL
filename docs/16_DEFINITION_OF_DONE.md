# DEFINITION OF DONE

Version: 1.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# MỤC ĐÍCH

Tài liệu này quy định tiêu chí để một thay đổi được xem là hoàn thành.

Mọi Feature, Bug Fix, Refactor hoặc Documentation đều phải đáp ứng các tiêu chí dưới đây trước khi Merge hoặc Release.

---

# NGUYÊN TẮC

Một thay đổi chỉ được xem là Done khi:

- Đúng yêu cầu
- Đúng kiến trúc
- Đã kiểm thử
- Đã review
- Có thể bảo trì
- Không phát sinh Regression

Code chạy được KHÔNG đồng nghĩa với Done.

---

# 1. REQUIREMENT

□ Hiểu đúng yêu cầu.

□ Không tự ý thêm Feature.

□ Không bỏ sót yêu cầu.

□ Không thay đổi hành vi ngoài phạm vi yêu cầu.

□ Nếu yêu cầu chưa rõ phải hỏi lại.

---

# 2. ARCHITECTURE

□ Tuân thủ Project Architecture.

□ Không tạo Circular Dependency.

□ Không tăng Coupling.

□ Tăng hoặc giữ Cohesion.

□ Không phá Layer.

□ Core không phụ thuộc Business.

□ Business không gọi chéo trái quy định.

---

# 3. API

□ API có mục đích rõ ràng.

□ Một API chỉ làm một việc.

□ Input rõ ràng.

□ Output rõ ràng.

□ Return Code đúng chuẩn.

□ Không Hidden Dependency.

□ Không Side Effect.

□ Không phụ thuộc Caller.

---

# 4. BATCH SCRIPT

□ Không Hard-code Path.

□ Không Hard-code Error Code.

□ Quote đầy đủ.

□ Escape đầy đủ.

□ Validate Input.

□ Normalize Input.

□ Không làm bẩn Environment.

□ Restore Environment nếu thay đổi.

□ Không phụ thuộc Delayed Expansion của Caller.

□ Không thay đổi Current Directory.

□ Không thay đổi Code Page.

---

# 5. VARIABLE

□ Scope nhỏ nhất.

□ Không dùng Global Variable nếu không cần.

□ Không còn Dead Variable.

□ Không còn Duplicate Variable.

□ Không Magic Number.

---

# 6. ERROR HANDLING

□ Mọi API trả về ERRORLEVEL.

□ Caller kiểm tra ERRORLEVEL.

□ Cleanup trước khi Return.

□ Không Exit toàn chương trình.

□ Không mất ERRORLEVEL.

---

# 7. DOCUMENTATION

□ API mới có tài liệu.

□ Documentation được cập nhật.

□ Ví dụ được cập nhật nếu cần.

□ Changelog được cập nhật nếu ảnh hưởng người dùng.

---

# 8. TESTING

□ API Test Pass.

□ Module Test Pass.

□ Integration Test Pass.

□ Regression Test Pass.

□ Boundary Test Pass.

□ Invalid Input Test Pass.

□ Unicode Test Pass.

□ ErrorLevel Test Pass.

□ Side Effect Test Pass.

---

# 9. PERFORMANCE

□ Không giảm hiệu năng đáng kể.

□ Không tạo Loop dư.

□ Không tạo File tạm dư.

□ Không tăng Coupling.

---

# 10. REFACTOR

Nếu là Refactor

□ Không đổi Behavior.

□ Không Breaking Change.

□ Dễ Maintain hơn.

□ Dễ Test hơn.

□ Dễ mở rộng hơn.

---

# 11. REVIEW

□ Đã Architecture Review.

□ Đã API Review.

□ Đã Batch Script Review.

□ Đã Security Review.

□ Đã Performance Review.

□ Đã Documentation Review.

---

# 12. GIT

□ Branch đúng quy ước.

□ Commit Message đúng chuẩn.

□ Không Commit File tạm.

□ Không Commit Debug Code.

□ Không Commit Binary không cần thiết.

---

# 13. BUILD

□ Build thành công.

□ Không Error.

□ Không Warning nghiêm trọng.

□ Chạy được từ môi trường sạch.

---

# 14. RELEASE

□ Phiên bản được cập nhật.

□ Changelog cập nhật.

□ Tag sẵn sàng.

□ Có thể Release.

---

# 15. QUALITY GATE

Một thay đổi KHÔNG được Merge nếu còn:

■ Critical

■ High

Bug

Architecture

API

Testing

Documentation

---

# 16. SEVERITY

## Critical

Ví dụ

- Crash
- Data Loss
- Infinite Loop
- Environment Pollution
- Corrupt Output
- Security Issue

Không được Merge.

---

## High

Ví dụ

- Sai Business Logic
- Hidden Dependency
- API không độc lập
- Không kiểm tra ErrorLevel
- Side Effect

Không được Merge.

---

## Medium

Ví dụ

- Duplicate Code
- Hard-code
- Magic Number
- Maintainability thấp

Có thể Merge nếu được chấp thuận.

---

## Low

Ví dụ

- Naming
- Formatting
- Comment
- Readability

Có thể Merge.

---

# 17. DONE CHECKLIST

## Functional

□ Đúng yêu cầu

□ Không phát sinh Bug

□ Không Regression

---

## Technical

□ Coding Style

□ Architecture

□ API

□ Error Handling

□ Documentation

---

## Quality

□ Test Pass

□ Review Pass

□ Build Pass

---

## Release

□ Ready to Merge

□ Ready to Release

---

# 18. DEFINITION OF DONE

Một thay đổi chỉ được xem là Done khi:

✓ Đúng yêu cầu.

✓ Đúng kiến trúc.

✓ Không còn Critical.

✓ Không còn High.

✓ Test Pass.

✓ Review Pass.

✓ Build Pass.

✓ Documentation cập nhật.

✓ Có thể Merge.

✓ Có thể Release.

---

# RED FLAGS

Critical

■ Code chạy nhưng chưa Test.

■ Chưa Review.

■ Không kiểm tra ERRORLEVEL.

■ Có Hidden Dependency.

■ Có Circular Dependency.

■ Có Environment Pollution.

■ Có Regression.

■ Documentation chưa cập nhật.

---

# MỤC TIÊU CUỐI CÙNG

Mọi thay đổi trong MPLAB_SOURCE_EXPORT_TOOL phải đạt:

- Correctness
- Reliability
- Maintainability
- Testability
- Reusability
- Extensibility
- Consistency
- Reviewability
- Release Readiness

Chỉ khi đáp ứng đầy đủ các tiêu chí trên thì thay đổi mới được xem là hoàn thành.