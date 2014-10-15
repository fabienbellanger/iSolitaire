//
//  BoardSelectionViewController.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 13/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "BoardSelectionViewController.h"
#import "GameViewController.h"
#import "BoardTypeList.h"
#import "BoardType.h"
#import "Board.h"

@interface BoardSelectionViewController ()

@property (nonatomic, strong) NSArray *boardsList;
@property (nonatomic, strong) Board *boardSelected;

@end

@implementation BoardSelectionViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	// Affichage des plateaux disponibles
	[self drawBoardsList];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:@"chooseBoard"])
	{
		GameViewController *gvc = (GameViewController *) segue.destinationViewController;
		gvc.board = self.boardSelected;
	}
}

/**
 * Choix du plateau de jeu
 *
 */
- (void) chooseBoard:(id)sender
{
	BoardType *selectedBoardType	= [self.boardsList objectAtIndex:[sender tag]];
	self.boardSelected						= [[Board alloc] initWithBoardType:selectedBoardType];
	
	[self performSegueWithIdentifier:@"chooseBoard" sender:self];
}

/**
 * Affichage des différents plateaux de jeu disponibles
 *
 */
- (void) drawBoardsList
{
	// Plateaux de jeu
	self.boardsList = [[NSArray alloc] initWithArray: [[BoardTypeList initList] getAllTypes]];
	int nbBoards		= (int) [self.boardsList count];
	int i;
	UIButton *btBoard;
	NSMutableDictionary *buttonsList = [[NSMutableDictionary alloc] init];
	NSLayoutConstraint *constraint;
	
	// Afichage des plateaux
	i = 0;
	while (!(i == nbBoards))
	{
		btBoard	= [UIButton buttonWithType:UIButtonTypeRoundedRect];
		btBoard.translatesAutoresizingMaskIntoConstraints = NO;
		[btBoard sizeToFit];
		[btBoard setTag: i];
		[btBoard setTitle:[[self.boardsList objectAtIndex:i] name] forState:UIControlStateNormal];
		[btBoard addTarget:self
								action:@selector(chooseBoard:)
			forControlEvents:UIControlEventTouchUpInside];
		
		[self.view addSubview:btBoard];
		
		[buttonsList setObject:btBoard forKey:[[self.boardsList objectAtIndex:i] name]];
		
		i++;
	}
	
	i = 0;
	for (id key in buttonsList)
	{
		// Contraintes
		// -> Horizontale
		constraint = [NSLayoutConstraint constraintWithItem:buttonsList[key]
																							attribute:NSLayoutAttributeCenterX
																							relatedBy:NSLayoutRelationEqual
																								 toItem:self.view
																							attribute:NSLayoutAttributeCenterX
																						 multiplier:1.0
																							 constant:0.0];
		[self.view addConstraint:constraint];
		
		// -> Haut
		constraint = [NSLayoutConstraint constraintWithItem:buttonsList[key]
																							attribute:NSLayoutAttributeTop
																							relatedBy:NSLayoutRelationEqual
																								 toItem:self.view
																							attribute:NSLayoutAttributeTop
																						 multiplier:1.0
																							 constant:120.0 + i * 50.0];
		[self.view addConstraint:constraint];
		
		i++;
	}
}

@end
