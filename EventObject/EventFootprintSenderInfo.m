//
//  EventFootprintSenderInfo.m
//  EventTracer
//
//  Created by vedon on 9/28/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import "EventFootprintSenderInfo.h"
@interface EventFootprintSenderInfo()
@property (assign,nonatomic) uint64_t receiverAddr;
@property (assign,nonatomic) uint64_t senderAddr;
@property (copy,nonatomic) NSString *selector;
@property (copy,nonatomic) NSString *senderName;
@property (copy,nonatomic) NSString *receiverName;


@property (retain,nonatomic) id sender;
@property (retain,nonatomic) id receiver;
@property (retain,nonatomic) UIEvent *event;
@end
@implementation EventFootprintSenderInfo

- (instancetype)initWithSender:(id)sender receiver:(id)receiver action:(SEL)selector event:(UIEvent *)event
{
    self = [super init];
    if (self) {
        self.sender = sender;
        self.receiver = receiver;
        self.event = event;
        
        uint64_t receiverAddr = (uint64_t)receiver;
        uint64_t senderAddr = (uint64_t)sender;
        
        self.receiverAddr = receiverAddr;
        self.senderAddr = senderAddr;
        self.selector = NSStringFromSelector(selector);
        self.senderName = NSStringFromClass([sender class]);
        self.receiverName = NSStringFromClass([receiver class]);
        
    }
    return self;
}


- (void)dealloc
{
    [_senderName release];
    _senderName = nil;
    
    [_receiverName release];
    _receiverName = nil;
    
    [_event release];
    _event = nil;
    
    [_sender release];
    _sender = nil;
    
    [_receiver release];
    _receiver = nil;
    
    [_selector release];
    _selector = nil;
    
    [super dealloc];
}


#pragma mark - EventFootprintProtocol
- (NSString *)objectName
{
    NSString *senderDes = nil;
    if ([self.sender isKindOfClass:[UIButton class]]) {
        UIButton *tempButton = self.sender;
        if (tempButton.titleLabel.text.length) {
            senderDes = [NSString stringWithFormat:@"(%@)",tempButton.titleLabel.text];
        }else if(tempButton.accessibilityLabel.length)
        {
            senderDes = [NSString stringWithFormat:@"(%@)",tempButton.accessibilityLabel];
        }else
        {
            senderDes = @"";
        }
    }
    return [NSString stringWithFormat:@"%@'s %@%@ perform %@ selector",self.receiverName,self.senderName,senderDes,self.selector];
}

- (uint64_t)objectAddress
{
    return self.senderAddr;
}


@end
