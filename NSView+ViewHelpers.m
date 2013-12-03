//
//  NSView+ViewHelpers.m
//  WTFPL Licensed
// ----------------
// Use at your own risk. Modify and redistribute freely
//

#import "NSView+ViewHelpers.h"

static CGFloat PI = 3.14159;

typedef enum {
    TopQuad,
    RightQuad,
    BottomQuad,
    LeftQuad,
    
} DDRectQuadrant;

@implementation NSView (ViewHelpers)

-(void)removeAllSubviewsConformingToProtocol:(Protocol *)aprotocol
{
    NSArray *subviews = [[self subviews] copy];
    
    for (NSView *view in subviews) {
        
        if ([view conformsToProtocol:aprotocol]) {
            
            [view removeFromSuperview];
        }
    }

}

-(void)removeAllSubviews
{
    NSArray *subviews = [[self subviews] copy];
    
    for (NSView *view in subviews) {
       
        [view removeFromSuperview];
        
    }
    
}

-(NSPoint)center {
    
    NSRect frame = self.frame;
    
    return NSMakePoint(NSMidX(frame), NSMidY(frame));
    
}

-(void)setCenter:(NSPoint)apoint {
    
    NSRect frame = self.frame;
    
    frame.origin = NSMakePoint(NSMidX(frame) - NSWidth(frame)/2, NSMidY(frame) - NSHeight(frame)/2);
    
    self.frame = frame;
    
}

+(CGFloat)angleFrom:(CGPoint)pointA to:(CGPoint)pointB
{
    CGFloat deltax = pointA.x - pointB.x;
    CGFloat deltay = pointA.y - pointB.y;
    
    if (fabs(deltax) < 0.001) {
        deltax = 0.001;
    }
    
    CGFloat angle = atan(deltay/fabs(deltax))*180.0/PI;
    
    angle = (deltax < 0)? 180-angle:angle;
    
    return angle;
}


+(NSPoint)edgePointForAttackAngle:(CGFloat)angle inRect:(NSRect)arect
{
    DDRectQuadrant quad = [self quadForAttackAngle:angle inRect:arect];
    
    CGFloat anglerad = angle*PI/180;
    
    NSPoint rectCenter = [self rectCenter:arect];
    
    if (quad == TopQuad || quad == BottomQuad) {
        
        CGFloat opposite = NSHeight(arect)/2;
        CGFloat adjacent = opposite*tan(anglerad);
        
        opposite *= (quad == TopQuad)? 1:-1;
        adjacent *= (quad == TopQuad)? 1:-1;
        
        return NSMakePoint(rectCenter.x + adjacent, rectCenter.y + opposite);
        
    }
    else {
        
        CGFloat adjacent = NSWidth(arect)/2;
        
        CGFloat opposite = adjacent/tan(anglerad);
        
        adjacent *= (quad == RightQuad)? 1:-1;
        opposite *= (quad == RightQuad)? 1:-1;
        
        return NSMakePoint(rectCenter.x + adjacent, rectCenter.y + opposite);
        
        
    }
    
}

+(DDRectQuadrant)quadForAttackAngle:(CGFloat)attackangle inRect:(NSRect)arect
{
    CGFloat changeover = [self changeoverAngleForRect:arect];
    
    CGFloat lowerangle = (changeover + 2*(90-changeover));
    
    if (attackangle > (360 - changeover) || attackangle < changeover) {
        
        return TopQuad;
        
    }
    else if (attackangle > changeover && attackangle < lowerangle) {
        
        return RightQuad;
        
    }
    else if (attackangle > lowerangle && attackangle < (changeover + 180)) {
        
        return BottomQuad;
        
    }
    else {
        
        return LeftQuad;
        
    }
}




+(CGFloat)changeoverAngleForRect:(NSRect)rect
{
    
    return [self angleOfAttack:NSMakePoint(NSMaxX(rect), NSMaxY(rect)) forRect:rect];
    
}


+(CGFloat)angleOfAttack:(NSPoint)apoint forRect:(NSRect)arect
{
    
    NSPoint rcenter = [self rectCenter:arect];
    
    CGFloat deltax =  apoint.x - rcenter.x ;
    
    CGFloat deltay = apoint.y - rcenter.y;
    
    CGFloat rawangle = atan(deltax/deltay);
    
    if (deltay < 0 ) {
        rawangle += PI;
    }
    else if (deltax < 0) {
        rawangle += 2*PI;
    }
    
    CGFloat angledeg = rawangle * 180/PI;
    
    return angledeg;
    
    
}


+(NSPoint)rectCenter:(NSRect)arect {
    
    NSRect bounds = arect;
    
    return NSMakePoint(NSMidX(bounds), NSMidY(bounds));
    
}





@end
