//
//  EventFootprintObjectInfo.m
//  Bugtags
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import "EventFootprintObjectInfo.h"

@implementation EventFootprintObjectInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _controllerName = nil;
        _controllerAddr = 0;
        _controllerAccessibilityName = nil;
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        
        NSString *controllName = NSStringFromClass([controller class]);
        uint64_t controllerAddr = (uint64_t)(controller);
        
        _controllerName = [controllName retain];
        _controllerAddr = controllerAddr;
        _controllerAccessibilityName = controller.accessibilityLabel;
    }
    return self;
}

- (void)dealloc
{
    [_controllerName release];
    [_controllerAccessibilityName release];
    
    [super dealloc];
}

#pragma mark - EventFootprintProtocol
- (NSString *)objectName
{
    return [NSString stringWithFormat:@"%@(%@)",self.controllerAccessibilityName,self.controllerName];
}

- (uint64_t)objectAddress
{
    return self.controllerAddr;
}
@end
