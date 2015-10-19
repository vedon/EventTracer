//
//  EventFootprintGestureRecognizerInfo.h
//  EventTracer
//
//  Created by vedon on 10/9/15.
//
//

#import <Foundation/Foundation.h>
#import "EventFootprintProtocol.h"


@interface EventFootprintGestureRecognizerInfo : NSObject<EventFootprintProtocol>
- (instancetype)initWithGesture:(UIGestureRecognizer *)gesture;

@end
