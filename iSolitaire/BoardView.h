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

// =======================
// Déclaration du protocol
// =======================
@protocol gameStateDelegate <NSObject>

@required

- (void)getStateOfGame:(NSString *)state;

@end

@interface BoardView : UIView <selectCircleDelegate>
{
	NSMutableArray *circlesSelected;
	NSMutableArray *circlesList;
	id <gameStateDelegate> _delegate;
}

- (instancetype) initWithFrame:(CGRect)frame
												 board:(Board *)board;

@property (nonatomic, strong) Board *board;
@property (nonatomic, strong) id delegate;

@end
