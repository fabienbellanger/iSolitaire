//
//  GameViewController.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 07/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "GameViewController.h"
#import "BoardView.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Ajout du plateau de jeux
	CGRect boardViewFrame = CGRectMake(16.0, 100.0, 288.0, 288.8);
	BoardView *boardView = [[BoardView alloc] initWithFrame:boardViewFrame board:self.board];
	
	[self.view addSubview:boardView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
