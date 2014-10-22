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

int nbSecondsOfTimer;
NSTimer *timer;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Ajout du plateau de jeux
	CGRect boardViewFrame = CGRectMake(8.0, 100.0, 304.0, 304.0);
	BoardView *boardView	= [[BoardView alloc] initWithFrame:boardViewFrame board:self.board];
	
	[self.view addSubview:boardView];
	
	// Démarrage du compteur
	nbSecondsOfTimer			= 0;
	self.timerLabel.text	= [self getTimeStringFromSecond];
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0
																					 target:self
																				 selector:@selector(timerDisplay)
																				 userInfo:nil
																					repeats:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * Incrémentation du timer et modification du label
 *
 */
- (void) timerDisplay
{
	// A 59:59 on repart à zéro ie à (60 * 60 - 1)
	if (nbSecondsOfTimer == 3599)
		nbSecondsOfTimer = 0;
	else
		nbSecondsOfTimer++;
	self.timerLabel.text = [self getTimeStringFromSecond];;
}

/**
 * Affichage des secondes au format mm:ss
 *
 */
- (NSString *) getTimeStringFromSecond
{
	NSString *str;
	
	int minutes = (int) (nbSecondsOfTimer % 3600) / 60;
	int seconds = (int) (nbSecondsOfTimer % 3600) % 60;
	
	if (minutes < 10 && seconds < 10)
		str = [[NSString alloc] initWithFormat:@"0%d:0%d", minutes, seconds];
	else if (minutes < 10)
		str = [[NSString alloc] initWithFormat:@"0%d:%d", minutes, seconds];
	else if (seconds < 10)
		str = [[NSString alloc] initWithFormat:@"%d:0%d", minutes, seconds];
	else
		str = [[NSString alloc] initWithFormat:@"%d:%d", minutes, seconds];
	
	return str;
}

@end
