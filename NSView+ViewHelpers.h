//
//  NSView+ViewHelpers.h
//  WTFPL Licensed
// ----------------
// Use at your own risk. Modify and redistribute freely
//


#import <Cocoa/Cocoa.h>

@interface NSView (ViewHelpers)

-(void)removeAllSubviewsConformingToProtocol:(Protocol *)aprotocol;

-(void)removeAllSubviews;

-(NSPoint)center;

-(void)setCenter:(NSPoint)apoint;

+(CGFloat)angleFrom:(CGPoint)pointA to:(CGPoint)pointB;

+(CGFloat)angleOfAttack:(NSPoint)apoint forRect:(NSRect)arect;

+(NSPoint)edgePointForAttackAngle:(CGFloat)angle inRect:(NSRect)arect;

+(NSPoint)rectCenter:(NSRect)arect;

@end
