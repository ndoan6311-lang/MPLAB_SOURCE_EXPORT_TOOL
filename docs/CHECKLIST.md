# DEVELOPMENT CHECKLIST

Version: 2.0

Project:
MPLAB_SOURCE_EXPORT_TOOL

---

# BEFORE CODING

□ Đã hiểu yêu cầu.

□ Không đoán yêu cầu.

□ Không tự thêm Feature.

□ Đã xác định Module sẽ sửa.

□ Đã xác định API liên quan.

□ Không làm ảnh hưởng Module khác.

---

# ARCHITECTURE

□ Module chỉ có một trách nhiệm.

□ Không tạo Circular Dependency.

□ Coupling thấp.

□ Cohesion cao.

□ Không vi phạm Layer.

□ Core không phụ thuộc Business Module.

□ Business Module không gọi chéo nếu không cần.

---

# API

□ API chỉ làm một việc.

□ API có tên rõ nghĩa.

□ Input rõ ràng.

□ Output rõ ràng.

□ Return Code rõ ràng.

□ Không phụ thuộc Caller.

□ Không Hidden Dependency.

□ Không Side Effect.

□ Không thay đổi Environment ngoài ý muốn.

□ Có Documentation.

---

# PARAMETER

□ Validate Input.

□ Kiểm tra NULL.

□ Kiểm tra Empty String.

□ Kiểm tra Path.

□ Kiểm tra Unicode.

□ Kiểm tra ký tự đặc biệt.

□ Không tin tưởng Input.

---

# OUTPUT

□ Output nhất quán.

□ Không ghi đè dữ liệu ngoài ý muốn.

□ Return Code đúng.

□ Không trả Message thay cho Error Code.

---

# ERROR HANDLING

□ Luôn dùng EXIT /B.

□ Không EXIT toàn chương trình.

□ Không mất ERRORLEVEL.

□ Caller luôn kiểm tra ERRORLEVEL.

□ Cleanup trước khi Return.

□ Không Hard-code Error Code.

---

# BATCH SCRIPT

□ SETLOCAL đúng vị trí.

□ ENDLOCAL đúng vị trí.

□ Delayed Expansion đúng.

□ Không phụ thuộc Delayed Expansion của Caller.

□ Không đổi Current Directory.

□ Không đổi PATH.

□ Không đổi Code Page.

□ Restore Environment.

□ Quote đầy đủ.

□ Escape đầy đủ.

□ Xử lý khoảng trắng.

□ Xử lý Unicode.

□ Xử lý dấu !

□ Xử lý dấu ^

□ Xử lý dấu %

□ Xử lý dấu &

□ Xử lý dấu |

□ Xử lý dấu (

□ Xử lý dấu )

---

# VARIABLE

□ Scope nhỏ nhất.

□ Không Global Variable nếu không cần.

□ Không Hard-code.

□ Không Magic Number.

□ Không Dead Variable.

□ Không Duplicate Variable.

---

# PATH

□ Normalize Path.

□ Relative Path.

□ Absolute Path.

□ File Exists.

□ Folder Exists.

□ Long Path.

□ Unicode Path.

---

# FILE

□ File tồn tại.

□ Quyền truy cập.

□ Read Only.

□ Hidden.

□ Locked.

□ Cleanup File tạm.

---

# PERFORMANCE

□ Không Loop dư.

□ Không Scan dư.

□ Không CALL dư.

□ Không tạo File tạm không cần.

□ Không Duplicate xử lý.

---

# SECURITY

□ Không Hard-code Password.

□ Không Hard-code API Key.

□ Không Log thông tin nhạy cảm.

□ Validate Input.

---

# MAINTAINABILITY

□ Không Duplicate Code.

□ Không Code Smell.

□ Không God Function.

□ Không God Module.

□ Không Nested IF quá sâu.

□ Không Copy/Paste.

---

# REFACTOR

□ Không thay đổi Behavior.

□ Không Breaking Change.

□ Có lợi ích rõ ràng.

□ Giảm Coupling.

□ Tăng Cohesion.

□ Dễ Test hơn.

□ Dễ Maintain hơn.

---

# DOCUMENTATION

□ Public API có tài liệu.

□ Có Input.

□ Có Output.

□ Có Return Code.

□ Có Side Effect.

□ Có ví dụ nếu cần.

---

# TESTING

□ API Test.

□ Module Test.

□ Integration Test.

□ Regression Test.

□ Boundary Test.

□ Invalid Input Test.

□ Unicode Test.

□ ErrorLevel Test.

□ Side Effect Test.

---

# REVIEW

□ Có Bug.

□ Có Architecture Review.

□ Có API Review.

□ Có Batch Review.

□ Có Refactor Review.

□ Có Priority.

□ Có Recommendation.

□ Có Evidence.

---

# SEVERITY

Critical

□ Crash

□ Corrupt Data

□ Data Loss

□ Infinite Loop

□ Security Issue

---

High

□ API sai

□ Hidden Dependency

□ Side Effect

□ Environment Pollution

□ Sai Business Logic

---

Medium

□ Duplicate Code

□ Hard-code

□ Magic Number

□ Performance

□ Maintainability

---

Low

□ Naming

□ Formatting

□ Comment

□ Readability

---

# BEFORE COMMIT

□ Build thành công.

□ Test Pass.

□ Không Warning nghiêm trọng.

□ Documentation cập nhật.

□ Không Debug Code.

□ Không Comment thừa.

□ Không TODO bỏ quên.

□ Không File tạm.

□ Không Code chết.

---

# BEFORE RELEASE

□ Tất cả Test Pass.

□ Không còn Critical.

□ Không còn High.

□ Documentation đầy đủ.

□ Version cập nhật.

□ Changelog cập nhật.

□ Đã Review.

□ Có thể Release.

---

# DEFINITION OF DONE

Một thay đổi được xem là hoàn thành khi:

✓ Đúng yêu cầu.

✓ Không phát sinh Bug.

✓ Không thay đổi Behavior ngoài phạm vi.

✓ Test Pass.

✓ Review Pass.

✓ Documentation cập nhật.

✓ Không còn Critical.

✓ Không còn High.

✓ Có thể Merge.

✓ Có thể Release.