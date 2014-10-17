//
//  CircleView.h
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <UIKit/UIKit.h>

// =======================
// Déclaration du protocol
// =======================
@protocol selectCircleDelegate <NSObject>

@required

- (void) getXYCircle:(int)x
									 y:(int)y;

@end


@interface CircleView : UIView
{
	// Variable d'instance
	id <selectCircleDelegate> _delegate;
}

- (instancetype) initWithFrame:(CGRect)frame
												radius:(float)radius
														 x:(int)x
														 y:(int)y
												 state:(NSString *)state;

@property (nonatomic, readwrite) int x;
@property (nonatomic, readwrite) int y;
@property (nonatomic, readwrite) float radius;
@property (nonatomic, copy) NSString *state;
@property (nonatomic) BOOL selected;
@property (strong, nonatomic) UIBezierPath *path;
@property (nonatomic, strong) id delegate;

@end
