//
//  EventFootprintGestureRecognizerInfo.m
//  EventTracer
//
//  Created by vedon on 10/9/15.
//
//

#import "EventFootprintGestureRecognizerInfo.h"
@interface GestureInfo : NSObject
@property (copy,nonatomic) NSString *targetName;
@property (copy,nonatomic) NSString *actionName;
@property (copy,nonatomic) NSString *accessbiltyName;
@property (assign,nonatomic) uint64_t addr;
@end

@implementation GestureInfo

-(void)dealloc
{
    [_targetName release];
    [_actionName release];
    [_accessbiltyName release];
    [super dealloc];
}

@end

@interface EventFootprintGestureRecognizerInfo ()
@property (retain,nonatomic) GestureInfo *gestureInfo;
@end

@implementation EventFootprintGestureRecognizerInfo

- (instancetype)initWithGesture:(UIGestureRecognizer *)gesture
{
    self = [super init];
    if (self) {
        self.gestureInfo = [self getTargetNameFromGesture:gesture];
        
    }
    return self;
}

- (void)dealloc
{
    [_gestureInfo release];
    [super dealloc];
}

- (GestureInfo *)getTargetNameFromGesture:(UIGestureRecognizer *)gesture
{
    GestureInfo *gestureInfo = [[[GestureInfo alloc]init] autorelease];
    Ivar targetsIvar = class_getInstanceVariable([UIGestureRecognizer class], "_targets");
    id targetActionPairs = object_getIvar(gesture, targetsIvar);
    
    Class targetActionPairClass = NSClassFromString(@"UIGestureRecognizerTarget");
    Ivar targetIvar = class_getInstanceVariable(targetActionPairClass, "_target");
    Ivar actionIvar = class_getInstanceVariable(targetActionPairClass, "_action");
    
    for (id targetActionPair in targetActionPairs)
    {
        id target = object_getIvar(targetActionPair, targetIvar);
        SEL action = (__bridge void *)object_getIvar(targetActionPair, actionIvar);
        gestureInfo.targetName = NSStringFromClass([target class]);
        gestureInfo.actionName = NSStringFromSelector(action);
        gestureInfo.accessbiltyName = [target valueForKey:@"accessibilityLabel"];
        gestureInfo.addr = (uint64_t)target;
        break;
    }
    return gestureInfo;
}

#pragma mark - EventFootprintProtocol
- (NSString *)objectName
{
    NSString *objectName = nil;
    if (self.gestureInfo.accessbiltyName.length)
    {
        objectName = [NSString stringWithFormat:@"%@(%@)",self.gestureInfo.accessbiltyName,self.gestureInfo.targetName];
    }else
    {
        objectName = self.gestureInfo.targetName;
    }
    return [NSString stringWithFormat:@"%@ perform selector:%@",objectName,self.gestureInfo.actionName];
}

- (uint64_t)objectAddress
{
    return self.gestureInfo.addr;
}
@end
