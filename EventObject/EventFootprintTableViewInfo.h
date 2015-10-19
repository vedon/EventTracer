//
//  EventFootprintTableViewInfo.h
//  EventTracer
//
//  Created by vedon on 10/19/15.
//
//

#import <Foundation/Foundation.h>
#import "EventFootprintProtocol.h"

@interface EventFootprintTableViewInfo : NSObject<EventFootprintProtocol>
@property (copy,nonatomic,readonly) NSString *tableName;
@property (copy,nonatomic,readonly) NSString *tableAccessbilityName;
@property (assign,nonatomic,readonly) uint64_t addr;
@property (retain,nonatomic,readonly) NSIndexPath *selectedIndexPath;

- (instancetype)initWithTableView:(UITableView *)table selectedIndexPath:(NSIndexPath *)selectedIndexPath;
@end
