//
//  CircleView.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	float radius;
	UIBezierPath *path = [[UIBezierPath alloc] init];
	CGRect bounds = self.bounds;
	CGPoint center;
	
	radius = MIN(bounds.size.width, bounds.size.height) / 10.0;
	center.x = bounds.origin.x + bounds.size.width / 2.0;
	center.y = bounds.origin.y + bounds.size.width / 2.0;
	
	[path addArcWithCenter:center
									radius:radius
							startAngle:0.0
								endAngle:M_PI * 2.0
							 clockwise:YES];
	
	[[UIColor greenColor] setFill];
	[path fill];
}

@end
