//
//  BoardView.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "BoardView.h"
#import "CircleView.h"

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
		self->circlesSelected = [[NSMutableArray alloc] init];
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
	int i, j;
	
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
			if (![[self.board getValueAtX:i y:j] isEqualToString:@"0"])
			{
				circle	= [[CircleView alloc] initWithFrame:circleRect
																						 radius:(circleRadius / 2.5)
																								  x:i
																								  y:j
																							state:[self.board getValueAtX:i y:j]];
				circle.delegate = self;
				[self addSubview:circle];
			}
			
			j++;
		}
		i++;
	}
}

- (void)getXYCircle:(int)x
									y:(int)y
{
	int nbCircles = (int)[self->circlesSelected count];
	
	NSLog(@"(%d,%d) : %d", x, y, nbCircles);
	
	if (nbCircles == 0)
	{
		// Premier cercle sélectionné
		NSArray *circleCoordonates = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:x], [NSNumber numberWithInt:y], nil];
		[self->circlesSelected addObject:circleCoordonates];
	}
	else if (nbCircles == 1)
	{
		// Second cercle sélectionné
		NSArray *circleCoordonates = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:x], [NSNumber numberWithInt:y], nil];
		[self->circlesSelected addObject:circleCoordonates];
		
		// Mouvement
		/*[self.board moveTo:[[[self->circlesSelected objectAtIndex:0] objectAtIndex:0] intValue]
								 yFrom:[[[self->circlesSelected objectAtIndex:0] objectAtIndex:1] intValue]
									 xTo:[[[self->circlesSelected objectAtIndex:1] objectAtIndex:0] intValue]
									 yTo:[[[self->circlesSelected objectAtIndex:1] objectAtIndex:1] intValue]];
		[self.board drawBoard];
		
		// Rafraichissement de la vue
		[self setNeedsDisplay];
		
		// Vidage du tableau
		[self->circlesSelected removeAllObjects];*/
	}
}


@end
