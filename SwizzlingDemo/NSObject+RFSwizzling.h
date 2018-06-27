//
//  NSObject+RFSwizzling.h
//  SwizzlingDemo
//
//  Created by riceFun on 2018/6/27.
//  Copyright © 2018年 riceFun. All rights reserved.
//



/**
 二者有什么区别
 Method swizzling
 影响一个类的所有对象（实例）
 对象都指向的同一个类
 调用API：void method_exchangeImplementations(Method m1, Method m2)实现混写
 
 ISA swizzling
 只会影响到当前目标对象
 对象的类会发生变化
 使用子类技术混写，即必须保证混写类的大小相等，调用API：Class object_setClass(id obj, Class cls)实现
 */

#import <Foundation/Foundation.h>

//定义设置Error宏
#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)    \
if (ERROR_VAR) {    \
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1    \
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}
#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

@interface NSObject (RFSwizzling)

//MARK: - Method swizzling
//instance Method swizzling
+ (BOOL)rf_swizzleInstanceMethodWithOrigSel:(SEL)origSel withNewSel:(SEL)newSel error:(NSError**)error;

//class Method swizzling  Class实质上也是一个对象
+ (BOOL)rf_swizzleClassMethodWithOrigSel:(SEL)origSel withNewSel:(SEL)newSel error:(NSError**)error;

//MARK: - isa swizzling  对象的isa指针定义了它的类，所以ISA swizzling指修改对象所指向的类。
- (BOOL)rf_setClass:(Class)newClass error:(NSError**)error;

@end
