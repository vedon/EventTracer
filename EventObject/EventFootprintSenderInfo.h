//
//  EventFootprintSenderInfo.h
//  EventTracer
//
//  Created by vedon on 9/28/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventFootprintProtocol.h"

@interface EventFootprintSenderInfo : NSObject<EventFootprintProtocol>
@property (assign,nonatomic,readonly) uint64_t receiverAddr;
@property (assign,nonatomic,readonly) uint64_t senderAddr;
@property (copy,nonatomic,readonly) NSString  *selector;

@property (copy,nonatomic,readonly) NSString *senderName;
@property (copy,nonatomic,readonly) NSString *receiverName;
@property (retain,nonatomic,readonly) UIEvent *event;


- (instancetype)initWithSender:(id)sender receiver:(id)receiver action:(SEL)selector event:(UIEvent *)event;
@end
