//
//  GameViewController.h
//  iSolitaire
//
//  Created by Fabien BELLANGER on 07/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "BoardView.h"

@interface GameViewController : UIViewController <BoardViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) Board *board;

@end
