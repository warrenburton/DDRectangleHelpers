//
//  NSView+ViewHelpers.h
//  DevSketch
//
//  Created by Warren Burton on 01/12/2013.
//  Copyright (c) 2013 Warren Burton. All rights reserved.
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
