//
//  CircleView.h
//  iSolitaire
//
//  Created by Fabien BELLANGER on 11/10/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

- (instancetype) initWithFrame:(CGRect)frame
												radius:(float)radius
												 state:(int)state;

@property (nonatomic, readwrite) int state;
@property (nonatomic, readwrite) float radius;

@end
