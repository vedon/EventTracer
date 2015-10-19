//
//  Swizzler.m
//  Bugtags
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import "Swizzler.h"
#import <objc/runtime.h>

@implementation Swizzler

+ (void)hookSelector:(SEL)originalSelector toSelector:(SEL)swizzledSelector withClass:(Class)class
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
