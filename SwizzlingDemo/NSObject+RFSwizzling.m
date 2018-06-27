//
//  NSObject+RFSwizzling.m
//  SwizzlingDemo
//
//  Created by riceFun on 2018/6/27.
//  Copyright © 2018年 riceFun. All rights reserved.
//

#import "NSObject+RFSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (RFSwizzling)
//instance Method swizzling
+ (BOOL)rf_swizzleInstanceMethodWithOrigSel:(SEL)origSel withNewSel:(SEL)newSel error:(NSError**)error
{
    Method origMethod = class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!newMethod) {
        SetNSError(error, @"new method %@ not found for class %@", NSStringFromSelector(newSel), [self class]);
        return  NO;
    }
    
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
//    要实现方法混写，需要用到运行时API：void method_exchangeImplementations(Method m1, Method m2)
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, newSel));
    
    return YES;
}

//class Method swizzling  Class实质上也是一个对象
+ (BOOL)rf_swizzleClassMethodWithOrigSel:(SEL)origSel withNewSel:(SEL)newSel error:(NSError**)error{
    return [object_getClass((id)self) rf_swizzleInstanceMethodWithOrigSel:origSel withNewSel:newSel error:error];
}

//MARK: - isa swizzling  对象的isa指针定义了它的类，所以ISA swizzling指修改对象所指向的类。
- (BOOL)rf_setClass:(Class)newClass error:(NSError**)error{
    if (class_getInstanceSize([self class]) == class_getInstanceSize(newClass)) {
//        要实现方法混写，需要用到运行时API：Class object_setClass(id obj, Class cls)
        object_setClass(self, newClass);
        return YES;
    } else {
        SetNSError(error, @"classes must be same size to swizzle. original: %@ alternate: %@" , NSStringFromClass(newClass), NSStringFromClass([self class]));
        return NO;
    }
}



@end
