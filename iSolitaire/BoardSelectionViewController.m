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

@property (nonatomic, strong) NSMutableArray *boardsList;
@property (nonatomic, strong) Board *boardSelected;

@end

@implementation BoardSelectionViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	// Plateaux de jeu
	self.boardsList = [[NSMutableArray alloc] initWithArray: [[BoardTypeList initList] getAllTypes]];
	int nbBoards		= [self.boardsList count];
	int i;
	CGRect buttonRect;
	UIButton *btBoard;
	
	// Afichage des plateaux
	i = 0;
	while (!(i == nbBoards))
	{
		buttonRect	= CGRectMake(50, 100 + 40 * i, 100, 30);
		btBoard			= [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		[btBoard setTag: i];
		[btBoard setTitle:[[self.boardsList objectAtIndex:i] name] forState:UIControlStateNormal];
		[btBoard addTarget:self action:@selector(chooseBoard:) forControlEvents:UIControlEventTouchUpInside];
		btBoard.frame = buttonRect;
		[self.view addSubview:btBoard];
		i++;
	}
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

- (void) chooseBoard:(id)sender
{
	BoardType *selectedBoardType	= [self.boardsList objectAtIndex:[sender tag]];
	self.boardSelected						= [[Board alloc] initWithBoardType:selectedBoardType];
	
	[self performSegueWithIdentifier:@"chooseBoard" sender:self];
}

@end
