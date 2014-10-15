//
//  BoardView.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "BoardView.h"
#import "CircleView.h"
#import "BoardTypeList.h"
#import "BoardType.h"
#import "Board.h"

@implementation BoardView

/**
 * Initialisation du plateau de jeux
 *
 */
- (instancetype) initWithFrame:(CGRect)frame
												 board:(Board *)board
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.board						= board;
		self.backgroundColor	= [UIColor clearColor];
	}
	return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	int gridLength = (int)[self.board.grid count];
	
	// Dessin
  CGRect bounds				= self.bounds;
	float minLength			= MIN(bounds.size.width, bounds.size.height);
	float circleRadius	= minLength / gridLength;
	CGRect square				= CGRectMake(bounds.origin.x, bounds.origin.y, minLength, minLength);
	UIView *viewSquare	= [[UIView alloc] initWithFrame:square];
	CGRect circleRect;
	CircleView *circle;
	int i, j, circleState;
	
	// Vue carrée
	viewSquare.backgroundColor = [UIColor clearColor];
	[self addSubview:viewSquare];
	
	// Ajout d'un cercle
	i = 0;
	while (!(i == gridLength))
	{
		j = 0;
		while (!(j == gridLength))
		{
			circleRect = CGRectMake(i * circleRadius,
															j * circleRadius,
															circleRadius,
															circleRadius);
			if ([[self.board getValueAtX:i y:j] isEqualToString:@"0"])
				circleState = -1;
			else if ([[self.board getValueAtX:i y:j] isEqualToString:@"1"])
				circleState = 0;
			else
				circleState = 1;
			
			if (circleState >= 0)
			{
				circle	= [[CircleView alloc] initWithFrame:circleRect
																						 radius:(circleRadius / 2.5)
																							state:circleState];
				[self addSubview:circle];
			}
			
			j++;
		}
		i++;
	}
}


@end
