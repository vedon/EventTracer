//
//  EventFootprintTableViewInfo.m
//  EventTracer
//
//  Created by vedon on 10/19/15.
//
//

#import "EventFootprintTableViewInfo.h"
@interface EventFootprintTableViewInfo()
@property (copy,nonatomic) NSString *tableName;
@property (copy,nonatomic) NSString *tableAccessbilityName;
@property (assign,nonatomic) uint64_t addr;
@property (retain,nonatomic) NSIndexPath *selectedIndexPath;
@end
@implementation EventFootprintTableViewInfo

- (instancetype)initWithTableView:(UITableView *)table selectedIndexPath:(NSIndexPath *)selectedIndexPath
{
    self = [super init];
    if (self) {
        _addr = (uint64_t)table;
        self.tableName = NSStringFromClass([table class]);
        self.tableAccessbilityName = table.accessibilityLabel;
        self.selectedIndexPath = selectedIndexPath;
    }
    return self;
}


- (void)dealloc
{
    [_selectedIndexPath release];
    [_tableName release];
    [_tableAccessbilityName release];
    [super dealloc];
}

#pragma mark - EventFootprintProtocol
- (NSString *)objectName
{
    NSString *objectName = nil;
    if ([self.tableAccessbilityName length])
    {
        objectName = [NSString stringWithFormat:@"%@(%@)",self.tableAccessbilityName,self.tableName];
    }else
    {
        objectName = self.tableName;
    }
    return [NSString stringWithFormat:@"选中%@ 的 %@",objectName,self.selectedIndexPath];
}

- (uint64_t)objectAddress
{
    return self.addr;
}

@end
