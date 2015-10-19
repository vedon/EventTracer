
//
//  UIGestureRecognizer+EventDispatch.m
//  EventTracer
//
//  Created by vedon on 9/30/15.
//
//

#import "UIGestureRecognizer+EventDispatch.h"
#import "Swizzler.h"
#import "EventTracer.h"

@implementation UIGestureRecognizer (EventDispatch)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = NULL;
        SEL swizzledSelector = NULL;
        
        originalSelector = @selector(_updateGestureWithEvent:buttonEvent:);
        swizzledSelector = @selector(eventDispatchUpdateGestureWithEvent:buttonEvent:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
        
        
        originalSelector = @selector( _resetGestureRecognizer);
        swizzledSelector = @selector(eventDispatchResetGestureRecognizer);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
        
    
    });
}


- (void)eventDispatchUpdateGestureWithEvent:(UIEvent *)event buttonEvent:(UIEvent *)buttonEvent
{
    [self eventDispatchUpdateGestureWithEvent:event buttonEvent:buttonEvent];
}

- (BOOL)eventDispatchResetGestureRecognizer
{
    if (self.state == UIGestureRecognizerStateEnded)
    {
        [[EventTracer shareLogger] addFootprintWithGesture:self];
    }
   return [self eventDispatchResetGestureRecognizer];
}


@end
