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
		self->circlesList			= [[NSMutableArray alloc] init];
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
																						 radius:(circleRadius / 2.3)
																								  x:i
																								  y:j
																							state:[self.board getValueAtX:i y:j]];
				circle.delegate = self;
				[self addSubview:circle];
				
				// Ajout dans le tableau des cercles
				[self->circlesList addObject:circle];
			}
			else
			{
				// Ajout dans le tableau des cercles
				[self->circlesList addObject:@""];
			}
			
			j++;
		}
		i++;
	}
}


// =================================================================================================
//
// DELEGATES
//
// =================================================================================================

/**
 * Récupération des coordonnées d'un cercle et de son état (delegate provenant de CircleView)
 *
 */
- (void)getXYCircle:(int)x
									y:(int)y
							state:(NSString *)state
{
	int nbCircles = (int)[self->circlesSelected count];
	
	if (nbCircles == 0 && [state isEqualToString:@"1"])
	{
		// Premier cercle sélectionné est un pion
		NSArray *circleCoordonates = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:x], [NSNumber numberWithInt:y], nil];
		[self->circlesSelected addObject:circleCoordonates];
	}
	else if (nbCircles == 1 && [state isEqualToString:@"2"])
	{
		// Second cercle sélectionné est un trou
		NSArray *circleCoordonates = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:x], [NSNumber numberWithInt:y], nil];
		[self->circlesSelected addObject:circleCoordonates];
		
		// Mouvement
		int gridLength	= (int)[self.board.grid count];
		int xFrom				= [[[self->circlesSelected objectAtIndex:0] objectAtIndex:0] intValue];
		int yFrom				= [[[self->circlesSelected objectAtIndex:0] objectAtIndex:1] intValue];
		int xTo					= [[[self->circlesSelected objectAtIndex:1] objectAtIndex:0] intValue];
		int yTo					= [[[self->circlesSelected objectAtIndex:1] objectAtIndex:1] intValue];
		int indexFrom		= yFrom + gridLength * xFrom;
		int indexTo			= yTo + gridLength * xTo;
		int indexMiddle = abs(indexFrom + indexTo) / 2;
		
		BOOL movementAuthorized = [self.board moveTo:xFrom
																					 yFrom:yFrom
																						 xTo:xTo
																						 yTo:yTo];

		if (movementAuthorized)
		{
			CircleView *circleFrom = [self->circlesList objectAtIndex:indexFrom];
			[circleFrom changeStateAndRedraw:@"2" selected:false];
			
			CircleView *circleTo = [self->circlesList objectAtIndex:indexTo];
			[circleTo changeStateAndRedraw:@"1" selected:false];
			
			CircleView *circleMiddle = [self->circlesList objectAtIndex:indexMiddle];
			[circleMiddle changeStateAndRedraw:@"2" selected:false];
		}
		else
		{
			CircleView *circleFrom = [self->circlesList objectAtIndex:indexFrom];
			[circleFrom changeStateAndRedraw:circleFrom.state selected:false];
			
			CircleView *circleTo = [self->circlesList objectAtIndex:indexTo];
			[circleTo changeStateAndRedraw:circleTo.state selected:false];
		}
		
		// Vidage du tableau
		[self->circlesSelected removeAllObjects];
		
		// Le jeu est-il gagné ?
		if ([self.board isGameWinned])
		{
			// Gagné
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iSolitaire"
																											message:@"Bravo ! Vous avez gagné."
																										 delegate:self
																						cancelButtonTitle:@"OK"
																						otherButtonTitles:nil];
			[alert show];
		}
		else
		{
			int nbMovementsPossible = [self.board nbTotalPossibleMovements];
			if (nbMovementsPossible == 0)
			{
				// Perdu
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iSolitaire"
																												message:[[NSString alloc] initWithFormat:@"Perdu ! Il reste %d pions", [self.board nbPlainCirclesRemaining]]
																											 delegate:self
																							cancelButtonTitle:@"OK"
																							otherButtonTitles:nil];
				[alert show];
			}
		}
		
		// Etat du jeu (Delegate)
		if ([self.delegate respondsToSelector:@selector(getStateOfGame:)])
		{
			// La méthode est appelée avec le nom de la tâche en paramètre
			[self.delegate getStateOfGame:self.board.state];
		}
	}
	else
	{
		// Déplacement non possible
		int gridLength	= (int)[self.board.grid count];
		
		if ([self->circlesSelected count] > 0)
		{
			// Mouvement
			int xFrom				= [[[self->circlesSelected objectAtIndex:0] objectAtIndex:0] intValue];
			int yFrom				= [[[self->circlesSelected objectAtIndex:0] objectAtIndex:1] intValue];
			int indexFrom		= yFrom + gridLength * xFrom;
			
			CircleView *circleFrom = [self->circlesList objectAtIndex:indexFrom];
			[circleFrom changeStateAndRedraw:circleFrom.state selected:false];
			
			if ([self->circlesSelected count] > 1)
			{
				int xTo					= [[[self->circlesSelected objectAtIndex:1] objectAtIndex:0] intValue];
				int yTo					= [[[self->circlesSelected objectAtIndex:1] objectAtIndex:1] intValue];
				int indexTo			= yTo + gridLength * xTo;
				
				CircleView *circleTo = [self->circlesList objectAtIndex:indexTo];
				[circleTo changeStateAndRedraw:circleTo.state selected:false];
			}
			else
			{
				int index		= y + gridLength * x;
				
				CircleView *circle = [self->circlesList objectAtIndex:index];
				[circle changeStateAndRedraw:circle.state selected:false];
			}
			
			// Vidage du tableau
			[self->circlesSelected removeAllObjects];
		}
		else
		{
			int index		= y + gridLength * x;
			
			CircleView *circle = [self->circlesList objectAtIndex:index];
			[circle changeStateAndRedraw:circle.state selected:false];
		}
	}
}

@end
