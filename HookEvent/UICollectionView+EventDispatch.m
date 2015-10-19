//
//  UICollectionView+EventDispatch.m
//  EventTracer
//
//  Created by vedon on 10/19/15.
//
//

#import "UICollectionView+EventDispatch.h"
#import "Swizzler.h"
#import "EventTracer.h"

@implementation UICollectionView (EventDispatch)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(_selectItemAtIndexPath:animated:scrollPosition:notifyDelegate:);
        SEL swizzledSelector = @selector(eventDispatch_selectItemAtIndexPath:animated:scrollPosition:notifyDelegate:);
        [Swizzler hookSelector:originalSelector toSelector:swizzledSelector withClass:[self class]];
    });
}

- (void)eventDispatch_selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(CGPoint)position notifyDelegate:(id)delegate
{
    [self eventDispatch_selectItemAtIndexPath:indexPath animated:animated scrollPosition:position notifyDelegate:delegate];
}
@end
