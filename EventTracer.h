//
//  EventTracer.h
//  EventTracer
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTracer : NSObject

+ (instancetype)shareLogger;

- (void)addFootprintWithSendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event;

- (void)addFootprintWithTableView:(UITableView *)table selectedIndexPath:(NSIndexPath *)indexPath;

- (void)addFootprintWithGesture:(UIGestureRecognizer *)gesture;
@end
