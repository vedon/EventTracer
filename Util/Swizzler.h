//
//  Swizzler.h
//  Bugtags
//
//  Created by vedon on 9/26/15.
//  Copyright © 2015 bugtags.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Swizzler : NSObject
+ (void)hookSelector:(SEL)originalSelector toSelector:(SEL)swizzledSelector withClass:(Class)class;
@end
