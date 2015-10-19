//
//  EventFootprintProtocol.h
//  EventTracer
//
//  Created by vedon on 9/28/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#ifndef EventFootprintProtocol_h
#define EventFootprintProtocol_h
#import <Foundation/Foundation.h>
@protocol EventFootprintProtocol <NSObject>
@required
- (NSString *)objectName;
- (uint64_t)objectAddress;
@end

#endif /* EventFootprintProtocol_h */
