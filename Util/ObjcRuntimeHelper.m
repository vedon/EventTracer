//
//  ObjcRuntimeHelper.m
//  iUCWEB
//
//  Created by vedon on 10/19/15.
//
//

#import "ObjcRuntimeHelper.h"

@implementation ObjcRuntimeHelper

+ (void)getAllMethods
{
    unsigned int methodCount;
    Method *methodList = class_copyMethodList(self, &methodCount);
    unsigned int i = 0;
    for (; i < methodCount; i++) {
        NSLog(@"%@ - %@", [NSString stringWithCString:class_getName(self) encoding:NSUTF8StringEncoding], [NSString stringWithCString:sel_getName(method_getName(methodList[i])) encoding:NSUTF8StringEncoding]);
    }
    free(methodList);
    
}

@end
