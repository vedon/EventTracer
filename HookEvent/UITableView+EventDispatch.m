//
//  UITableView+EventDispatch.m
//  EventTracer
//
//  Created by vedon on 10/19/15.
//
//

#import "UITableView+EventDispatch.h"
#import "Swizzler.h"
#import "EventTracer.h"

@implementation UITableView (EventDispatch)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:);
        SEL swizzledSelector = @selector(eventDispatch_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
    });
}

- (void)eventDispatch_selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(CGPoint)point notifyDelegate:(id)delegate
{
    [self eventDispatch_selectRowAtIndexPath:indexPath animated:animated scrollPosition:point notifyDelegate:delegate];
    [[EventTracer shareLogger]addFootprintWithTableView:self selectedIndexPath:indexPath];
}
@end
