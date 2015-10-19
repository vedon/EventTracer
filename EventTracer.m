//
//  EventTracer.m
//  EventTracer
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//


#import "EventTracer.h"
#import "EventFootprintSenderInfo.h"
#import "EventFootprintGestureRecognizerInfo.h"
#import "EventFootprintProtocol.h"
#import "EventFootprintTableViewInfo.h"

#define CacheViewHierarchy 1
#define MaxRecordItem 15

@interface EventTracer()
@property (copy,nonatomic) NSString *filePath;
@property (retain,nonatomic) NSMutableArray *footprintVC;
@property (retain,nonatomic) NSArray *currentViewsInfo;
@property (assign,nonatomic) NSUInteger currentGroupIndex;
@end
@implementation EventTracer

+ (instancetype)shareLogger
{
    static EventTracer *logger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[EventTracer alloc]init];
    });
    return logger;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.footprintVC = [NSMutableArray array];
        self.currentViewsInfo = [NSArray array];
        self.currentGroupIndex = 0;
    }
    return self;
}

- (void)dealloc
{
    [_filePath release];
    _filePath = nil;
    
    [_footprintVC release];
    _footprintVC = nil;
    
    [_currentViewsInfo release];
    _currentViewsInfo = nil;
    
    [super dealloc];
}

#pragma mark - Public

- (void)addFootprintWithSendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event
{
    EventFootprintSenderInfo *senderInfo = [[[EventFootprintSenderInfo alloc]initWithSender:sender receiver:target action:action event:event] autorelease];
    assert(senderInfo);
    if (senderInfo)
    {
        [self.footprintVC addObject:senderInfo];
    }
    [self logFootprint];
}

- (void)addFootprintWithTableView:(UITableView *)table selectedIndexPath:(NSIndexPath *)indexPath
{
    EventFootprintTableViewInfo *tableInfo = [[EventFootprintTableViewInfo alloc]initWithTableView:table selectedIndexPath:indexPath];
    [self.footprintVC addObject:tableInfo];
    [self logFootprint];
}

- (void)addFootprintWithGesture:(UIGestureRecognizer *)gesture
{
    EventFootprintGestureRecognizerInfo *gestureInfo = [[[EventFootprintGestureRecognizerInfo alloc]initWithGesture:gesture]autorelease];
    [self.footprintVC addObject:gestureInfo];
    [self logFootprint];
}


#pragma mark - Utili

- (void)removeActionRecordWithController:(id)object
{
    
    NSInteger removeStartIndex = -1;
    for (int i =0; i< self.footprintVC.count ;i++)
    {
        id senderInfo = [self.footprintVC objectAtIndex:i];
        if ([senderInfo isKindOfClass:[EventFootprintSenderInfo class]])
        {
            removeStartIndex = i;
        }else
        {
            removeStartIndex = -1;
        }
    }
    if (removeStartIndex != -1)
    {
        [self.footprintVC removeObjectsInRange:NSMakeRange(removeStartIndex, self.footprintVC.count - removeStartIndex)];
    }
}

- (void)logFootprint
{
    if (self.footprintVC.count > MaxRecordItem + 1)
    {
        NSRange range = NSMakeRange(MaxRecordItem, self.footprintVC.count - MaxRecordItem);
        self.footprintVC =  [NSMutableArray arrayWithArray:[self.footprintVC subarrayWithRange:range]];
    }
    
    printf("\n\n\n");
    NSLog(@"*********************************");
    for (id<EventFootprintProtocol> object in self.footprintVC)
    {
        NSLog(@"%@",[object objectName]);
    }
    NSLog(@"*********************************");
}

#pragma mark - Getter && Setter
- (NSString *)filePath
{
    if (!_filePath) {
        
    }
    return _filePath;
}

@end
