//
//  GameViewController.m
//  iSolitaire
//
//  Created by Fabien BELLANGER on 07/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "GameViewController.h"
#import "CircleView.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet CircleView *circle;

@end

@implementation GameViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"%@", self.circle);
	//[self.title setTextColor: [UIColor greenColor]];
	// Do any additional setup after loading the view.
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
