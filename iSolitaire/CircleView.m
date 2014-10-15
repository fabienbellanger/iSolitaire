//
//  CircleView.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

/**
 * Initialisation
 *
 */
- (instancetype) initWithFrame:(CGRect)frame
												radius:(float)radius
												 state:(int)state
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.radius = radius;
		self.state  = state;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	UIBezierPath *path	= [[UIBezierPath alloc] init];
	CGRect bounds				= self.bounds;
	UIColor *color			= [UIColor darkGrayColor];
	CGPoint center;
	
	// Calcul du centre du rectangle
	center.x = bounds.origin.x + bounds.size.width / 2.0;
	center.y = bounds.origin.y + bounds.size.width / 2.0;
	
	// Tracé
	[path addArcWithCenter:center
									radius:self.radius
							startAngle:0.0
								endAngle:M_PI * 2.0
							 clockwise:YES];
	
	// Contour
	path.lineWidth = 1.5;
	[color setStroke];
	[path stroke];
	
	if (self.state == 0)
	{
		// Pion
		[color setFill];
		[path fill];
	}
}

@end
