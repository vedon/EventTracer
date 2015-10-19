//
//  UIApplication+EventDispatch.m
//  EventTracer
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import "UIApplication+EventDispatch.h"
#import "Swizzler.h"
#import "EventTracer.h"

@implementation UIApplication (EventDispatch)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:from:forEvent:);
        SEL swizzledSelector = @selector(eventDispatchSendAction:to:from:forEvent:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
        
        
        originalSelector = @selector(sendEvent:);
        swizzledSelector = @selector(eventDispatchSendEvent:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
        
        
        
        originalSelector = @selector(_clearTouchesForView:);
        swizzledSelector = @selector(eventDispatch_clearTouchesForView:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];

    });
}



- (void)eventDispatchSendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event
{
    [self eventDispatchSendAction:action to:target from:sender forEvent:event];
    [[EventTracer shareLogger] addFootprintWithSendAction:action to:target from:sender forEvent:event];
}

- (void)eventDispatchSendEvent:(UIEvent *)event
{
    [self eventDispatchSendEvent:event];

}

- (void)eventDispatch_clearTouchesForView:(UIView *)view
{
    [self eventDispatch_clearTouchesForView:view];
}

- (void)log:(id)something
{
    NSLog(@"%@",something);
}

@end
