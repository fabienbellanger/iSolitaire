//
//  BoardView.h
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "CircleView.h"

@interface BoardView : UIView <selectCircleDelegate>
{
	NSMutableArray *circlesSelected;
	NSMutableArray *circlesList;
}

- (instancetype) initWithFrame:(CGRect)frame
												 board:(Board *)board;

@property (nonatomic, strong) Board *board;

@end
