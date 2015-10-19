//
//  EventFootprintObjectInfo.h
//  Bugtags
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventFootprintProtocol.h"

@interface EventFootprintObjectInfo : NSObject<EventFootprintProtocol>
@property (copy,nonatomic,readonly) NSString *controllerName;
@property (assign,nonatomic,readonly) uint64_t controllerAddr;
@property (copy,nonatomic,readonly) NSString *controllerAccessibilityName;


- (instancetype)initWithController:(UIViewController *)controller;
@end
