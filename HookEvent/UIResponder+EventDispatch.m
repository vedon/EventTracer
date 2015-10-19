//
//  UIResponder+EventDispatch.m
//  EventTracer
//
//  Created by vedon on 10/16/15.
//
//

#import "UIResponder+EventDispatch.h"
#import "Swizzler.h"

@implementation UIResponder (EventDispatch)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(targetForAction:withSender:);
        SEL swizzledSelector = @selector(eventDispatchtargetForAction:withSender:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
        
    });
}

- (id)eventDispatchtargetForAction:(id)actino  withSender:(id)sender
{
    id target = [self eventDispatchtargetForAction:actino withSender:sender];
    return target;
}
@end
