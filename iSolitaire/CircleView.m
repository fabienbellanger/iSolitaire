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
														 x:(int)x
														 y:(int)y
												 state:(NSString *)state
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.radius						= radius;
		self.x								= x;
		self.y								= y;
		self.state						= state;
		self.selected					= false;
		self.backgroundColor	= [UIColor clearColor];
		
		// Son
		NSURL *clickSound   = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sound1" ofType:@"wav"]];
		AudioServicesCreateSystemSoundID ((__bridge CFURLRef)clickSound, &self->sound);
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat: @"Circle: (%d,%d) state=%@", self.x, self.y, self.state];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	self.path							= [[UIBezierPath alloc] init];
	CGRect bounds					= self.bounds;
	UIColor *colorNormal	= [UIColor darkGrayColor];
	UIColor *colorTouch		=	[UIColor colorWithRed:24.0 / 255.0
																					green:116.0 / 255.0
																					 blue:205.0 / 255.0
																				  alpha:1.0];
	UIColor *color;
	CGPoint center;
	
	// Calcul du centre du rectangle
	center.x = bounds.origin.x + bounds.size.width / 2.0;
	center.y = bounds.origin.y + bounds.size.width / 2.0;
	
	// Tracé
	[self.path addArcWithCenter:center
												radius:self.radius
										startAngle:0.0
											endAngle:M_PI * 2.0
										 clockwise:YES];
	
	if (self.selected)
		color = colorTouch;
	else
		color = colorNormal;
	
	// Contour
	self.path.lineWidth = 1.5;
	[color setStroke];
	[self.path stroke];
	
	if ([self.state isEqualToString:@"1"])
	{
		// Pion
		[color setFill];
		[self.path fill];
	}
	else if ([self.state isEqualToString:@"2"])
	{
		// Pion
		[[UIColor clearColor] setFill];
		[self.path fill];
	}
}

- (void)touchesBegan:(NSSet *)touches
					 withEvent:(UIEvent *)event
{
	// Son
	AudioServicesPlaySystemSound(self->sound);
	
	CGPoint touchPoint = [touches.anyObject locationInView:self];
	if ([self.path containsPoint:touchPoint])
	{
		self.selected = !self.selected;
		
		// Delegate
		if ([self.delegate respondsToSelector:@selector(getXYCircle:y:)])
		{
			// La méthode est appelée avec le nom de la tâche en paramètre
			[self.delegate getXYCircle:self.x y:self.y];
		}
		
		// Rechergement de la vue (on relance drawRect)
		[self setNeedsDisplay];
	}
}

/**
 * Change d'état et redessine la vue
 *
 */
- (void) changeStateAndRedraw:(NSString *)state
										 selected:(BOOL)selected
{
	self.state		= state;
	self.selected = selected;
	
	// Rechergement de la vue (on relance drawRect)
	[self setNeedsDisplay];
}

@end
