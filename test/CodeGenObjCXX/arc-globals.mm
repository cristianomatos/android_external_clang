// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -emit-llvm -fblocks -fobjc-arc -O2 -disable-llvm-optzns -o - %s | FileCheck %s

// Test that we're properly retaining lifetime-qualified pointers
// initialized statically and wrapping up those initialization in an
// autorelease pool.
id getObject();

// CHECK: define internal void @__cxx_global_var_init
// CHECK: call i8* @_Z9getObjectv
// CHECK-NEXT: call i8* @objc_retainAutoreleasedReturnValue
// CHECK-NEXT: {{store i8*.*@global_obj}}
// CHECK-NEXT: ret void
id global_obj = getObject();

// CHECK: define internal void @__cxx_global_var_init
// CHECK: call i8* @_Z9getObjectv
// CHECK-NEXT: call i8* @objc_retainAutoreleasedReturnValue
// CHECK-NEXT: {{store i8*.*@global_obj2}}
// CHECK-NEXT: ret void
id global_obj2 = getObject();

// CHECK: define internal void @_GLOBAL__I_a
// CHECK: call i8* @objc_autoreleasePoolPush()
// CHECK-NEXT: call void @__cxx_global_var_init
// CHECK-NEXT: call void @__cxx_global_var_init1
// CHECK-NEXT: call void @objc_autoreleasePoolPop(
// CHECK-NEXT: ret void
